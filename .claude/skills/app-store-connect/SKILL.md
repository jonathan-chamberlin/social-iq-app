---
name: app-store-connect
description: Query and manage App Store Connect via the REST API — check build status, resolve compliance, list testers, manage TestFlight groups. Trigger on: "app store connect", "ASC", "build status", "compliance", "testflight status", "testers".
---

# App Store Connect API for Social IQ

## Authentication

- **Key ID:** S6QR8N472U
- **Issuer ID:** 8833fdf3-8efa-47a0-8777-442f8cc35999
- **Key path:** `~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8`
- **App ID:** 6761561557
- **Bundle ID:** com.jonathanchamberlin.Social-IQ

## Generating a JWT

The ASC API uses JWT bearer tokens. Generate one with:

```bash
# Requires: pip3 install PyJWT cryptography
python3 << 'PYEOF'
import jwt, time, json

KEY_ID = "S6QR8N472U"
ISSUER_ID = "8833fdf3-8efa-47a0-8777-442f8cc35999"
KEY_PATH = "~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8"

import os
with open(os.path.expanduser(KEY_PATH), "r") as f:
    private_key = f.read()

now = int(time.time())
payload = {
    "iss": ISSUER_ID,
    "iat": now,
    "exp": now + 1200,  # 20 minutes
    "aud": "appstoreconnect-v1",
}
token = jwt.encode(payload, private_key, algorithm="ES256", headers={"kid": KEY_ID})
print(token)
PYEOF
```

Store the token in a variable for subsequent requests:

```bash
TOKEN=$(python3 << 'PYEOF'
import jwt, time, os
with open(os.path.expanduser("~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8")) as f:
    key = f.read()
payload = {"iss": "8833fdf3-8efa-47a0-8777-442f8cc35999", "iat": int(time.time()), "exp": int(time.time()) + 1200, "aud": "appstoreconnect-v1"}
print(jwt.encode(payload, key, algorithm="ES256", headers={"kid": "S6QR8N472U"}))
PYEOF
)
```

## Common API operations

All requests use: `curl -s -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json"`

### List recent builds

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bapp%5D=6761561557&sort=-uploadedDate&limit=5" \
  | python3 -m json.tool
```

Key fields in response: `attributes.version`, `attributes.uploadedDate`, `attributes.processingState` (PROCESSING, FAILED, INVALID, VALID), `attributes.buildAudienceType`.

### Check build processing status

```bash
BUILD_ID="<build-id-from-list>"
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.appstoreconnect.apple.com/v1/builds/$BUILD_ID" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['data']['attributes']['processingState'])"
```

### Resolve export compliance (set encryption to exempt)

```bash
BUILD_ID="<build-id>"
curl -s -X PATCH -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  "https://api.appstoreconnect.apple.com/v1/builds/$BUILD_ID" \
  -d '{
    "data": {
      "type": "builds",
      "id": "'"$BUILD_ID"'",
      "attributes": {
        "usesNonExemptEncryption": false
      }
    }
  }'
```

### Add build to beta group (Dev Testing)

First, find the beta group ID:

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.appstoreconnect.apple.com/v1/apps/6761561557/betaGroups" \
  | python3 -c "import sys,json; [print(g['id'], g['attributes']['name']) for g in json.load(sys.stdin)['data']]"
```

Then add the build:

```bash
GROUP_ID="<group-id>"
BUILD_ID="<build-id>"
curl -s -X POST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  "https://api.appstoreconnect.apple.com/v1/betaGroups/$GROUP_ID/relationships/builds" \
  -d '{
    "data": [{"type": "builds", "id": "'"$BUILD_ID"'"}]
  }'
```

### List beta testers

```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.appstoreconnect.apple.com/v1/betaTesters?filter%5Bapps%5D=6761561557" \
  | python3 -c "import sys,json; [print(t['attributes']['email'], t['attributes']['firstName']) for t in json.load(sys.stdin)['data']]"
```

## Full automated post-upload flow

After `xcodebuild -exportArchive` succeeds, run this to resolve compliance and add to testing:

```bash
# 1. Generate token
TOKEN=$(python3 -c "
import jwt, time, os
with open(os.path.expanduser('~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8')) as f: key = f.read()
print(jwt.encode({'iss':'8833fdf3-8efa-47a0-8777-442f8cc35999','iat':int(time.time()),'exp':int(time.time())+1200,'aud':'appstoreconnect-v1'}, key, algorithm='ES256', headers={'kid':'S6QR8N472U'}))
")

# 2. Poll for build to finish processing (check every 30s, max 10 min)
echo "Waiting for build to process..."
for i in $(seq 1 20); do
  STATE=$(curl -s -H "Authorization: Bearer $TOKEN" \
    "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bapp%5D=6761561557&sort=-uploadedDate&limit=1" \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['data'][0]['attributes']['processingState'])")
  echo "  Build state: $STATE"
  if [ "$STATE" = "VALID" ]; then break; fi
  if [ "$STATE" = "FAILED" ] || [ "$STATE" = "INVALID" ]; then echo "ERROR: Build $STATE"; exit 1; fi
  sleep 30
done

# 3. Get build ID
BUILD_ID=$(curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bapp%5D=6761561557&sort=-uploadedDate&limit=1" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['data'][0]['id'])")
echo "Build ID: $BUILD_ID"

# 4. Set encryption exempt
curl -s -X PATCH -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  "https://api.appstoreconnect.apple.com/v1/builds/$BUILD_ID" \
  -d '{"data":{"type":"builds","id":"'"$BUILD_ID"'","attributes":{"usesNonExemptEncryption":false}}}'
echo "Compliance resolved"
```

## Dependencies

Requires PyJWT for token generation:

```bash
pip3 install PyJWT cryptography
```

## Notes

- Tokens expire after 20 minutes — regenerate if you get 401 errors
- Build processing typically takes 5-15 minutes after upload
- The `usesNonExemptEncryption: false` setting is correct for Social IQ (HTTPS only)
- Compliance resolution auto-distributes to the Dev Testing group
