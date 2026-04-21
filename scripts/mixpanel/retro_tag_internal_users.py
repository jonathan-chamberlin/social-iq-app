#!/usr/bin/env python3
"""Retroactively tag pre-launch Mixpanel users as internal.

Any user whose first-seen timestamp is before the App Store launch cutoff
(2026-04-20 16:00 UTC) is flagged with:

    is_internal = true
    build_type  = "pre_launch_internal"

Flow:
1. Query the Engage API to page through every user.
2. For each user whose `$last_seen` (or `first_seen` if present) is before the
   cutoff, queue a $set update.
3. POST batches of <=50 $set operations to /engage#profile-set.

Requires env: MIXPANEL_PROJECT_ID, MIXPANEL_TOKEN, MIXPANEL_API_SECRET
(reads from ~/repos/social-iq/.env.mixpanel).

Usage:
    python3 retro_tag_internal_users.py --dry-run
    python3 retro_tag_internal_users.py --commit
"""

from __future__ import annotations

import argparse
import base64
import json
import os
import sys
import urllib.parse
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

LAUNCH_CUTOFF = datetime(2026, 4, 20, 16, 0, 0, tzinfo=timezone.utc)
ENV_FILE = Path.home() / "repos" / "social-iq" / ".env.mixpanel"
ENGAGE_QUERY_URL = "https://mixpanel.com/api/query/engage"
ENGAGE_INGEST_URL = "https://api.mixpanel.com/engage"
BATCH_SIZE = 50


def load_env() -> dict[str, str]:
    env: dict[str, str] = {}
    if not ENV_FILE.exists():
        sys.exit(f"Missing env file: {ENV_FILE}")
    for raw in ENV_FILE.read_text().splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        env[key.strip()] = value.strip().strip('"').strip("'")
    required = ["MIXPANEL_PROJECT_ID", "MIXPANEL_TOKEN", "MIXPANEL_API_SECRET"]
    missing = [k for k in required if not env.get(k)]
    if missing:
        sys.exit(f"Missing required env keys: {', '.join(missing)}")
    return env


def basic_auth_header(api_secret: str) -> str:
    token = base64.b64encode(f"{api_secret}:".encode()).decode()
    return f"Basic {token}"


def fetch_users(project_id: str, api_secret: str) -> list[dict]:
    """Page through all users via the Engage query API."""
    results: list[dict] = []
    session_id: str | None = None
    page = 0
    while True:
        params: dict[str, str] = {"project_id": project_id}
        if session_id is not None:
            params["session_id"] = session_id
            params["page"] = str(page)
        url = f"{ENGAGE_QUERY_URL}?{urllib.parse.urlencode(params)}"
        request = urllib.request.Request(
            url,
            headers={"Authorization": basic_auth_header(api_secret)},
            method="POST",
        )
        with urllib.request.urlopen(request, timeout=60) as response:
            payload = json.loads(response.read().decode())
        batch = payload.get("results") or []
        results.extend(batch)
        total = payload.get("total", 0)
        session_id = payload.get("session_id")
        if not batch or len(results) >= total:
            break
        page += 1
    return results


def parse_first_seen(properties: dict) -> datetime | None:
    # Mixpanel stores profile timestamps as ISO-8601 in $last_seen.
    # first_seen isn't a default reserved property, so fall back to $last_seen.
    candidates = [properties.get("first_seen"), properties.get("$last_seen")]
    for raw in candidates:
        if not raw:
            continue
        try:
            parsed = datetime.fromisoformat(str(raw).replace("Z", "+00:00"))
        except ValueError:
            continue
        if parsed.tzinfo is None:
            parsed = parsed.replace(tzinfo=timezone.utc)
        return parsed
    return None


def build_set_payload(token: str, distinct_id: str) -> dict:
    return {
        "$token": token,
        "$distinct_id": distinct_id,
        "$set": {
            "is_internal": True,
            "build_type": "pre_launch_internal",
        },
    }


def post_batch(batch: list[dict]) -> None:
    body = urllib.parse.urlencode({"data": json.dumps(batch)}).encode()
    request = urllib.request.Request(
        ENGAGE_INGEST_URL,
        data=body,
        headers={"Content-Type": "application/x-www-form-urlencoded"},
        method="POST",
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        text = response.read().decode().strip()
    if text != "1":
        raise RuntimeError(f"Mixpanel rejected batch: {text}")


def main() -> None:
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--dry-run", action="store_true", help="Show what would change without writing")
    group.add_argument("--commit", action="store_true", help="Write $set updates to Mixpanel")
    args = parser.parse_args()

    env = load_env()
    users = fetch_users(env["MIXPANEL_PROJECT_ID"], env["MIXPANEL_API_SECRET"])
    print(f"Fetched {len(users)} user profiles")

    to_tag: list[tuple[str, datetime]] = []
    skipped_already_tagged = 0
    skipped_post_launch = 0
    skipped_no_timestamp = 0

    for user in users:
        distinct_id = user.get("$distinct_id")
        properties = user.get("$properties") or {}
        if not distinct_id:
            continue
        if properties.get("is_internal") is True:
            skipped_already_tagged += 1
            continue
        first_seen = parse_first_seen(properties)
        if first_seen is None:
            skipped_no_timestamp += 1
            continue
        if first_seen >= LAUNCH_CUTOFF:
            skipped_post_launch += 1
            continue
        to_tag.append((distinct_id, first_seen))

    print(f"  will tag:            {len(to_tag)}")
    print(f"  already tagged:      {skipped_already_tagged}")
    print(f"  post-launch (real):  {skipped_post_launch}")
    print(f"  no first-seen:       {skipped_no_timestamp}")

    if args.dry_run:
        for distinct_id, ts in to_tag[:10]:
            print(f"  would tag {distinct_id} (first seen {ts.isoformat()})")
        if len(to_tag) > 10:
            print(f"  ... and {len(to_tag) - 10} more")
        return

    token = env["MIXPANEL_TOKEN"]
    for i in range(0, len(to_tag), BATCH_SIZE):
        chunk = to_tag[i : i + BATCH_SIZE]
        payload = [build_set_payload(token, distinct_id) for distinct_id, _ in chunk]
        post_batch(payload)
        print(f"  wrote batch {i // BATCH_SIZE + 1}: {len(chunk)} users")
    print(f"Done. Tagged {len(to_tag)} users as internal.")


if __name__ == "__main__":
    main()
