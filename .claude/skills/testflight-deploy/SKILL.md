---
name: testflight-deploy
description: Archive, upload, and deploy a new build to TestFlight for Social IQ. Trigger on: "testflight", "deploy", "upload build", "new build", "archive".
model: sonnet
---

# TestFlight Deploy for Social IQ

## App Store Connect details

- **App:** Social IQ - Charisma Training
- **Bundle ID:** com.jonathanchamberlin.Social-IQ
- **Team ID:** 35373542G8
- **App Store Connect URL:** https://appstoreconnect.apple.com/teams/8833fdf3-8efa-47a0-8777-442f8cc35999/apps/6761561557/testflight/ios
- **Internal testing group:** Dev Testing (auto-receives builds immediately - compliance resolves automatically)

## App Store Connect API Key

- **Key ID:** S6QR8N472U
- **Issuer ID:** 8833fdf3-8efa-47a0-8777-442f8cc35999
- **Key path:** `~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8`

## Full CLI deploy process

All steps run from the CLI — no Xcode GUI needed.

### Step 1 — Bump build number

```bash
cd /Users/jonathanchamberlin/repos/social-iq
CURRENT=$(agvtool what-version -terse)
NEXT=$((CURRENT + 1))
agvtool new-version -all $NEXT
echo "Bumped build number from $CURRENT to $NEXT"
```

The "Cannot find" warning about `YES` is harmless — ignore it.

### Step 2 — Archive

```bash
xcodebuild archive \
  -project "Social IQ.xcodeproj" \
  -scheme "Social IQ" \
  -destination "generic/platform=iOS" \
  -archivePath /tmp/SocialIQ.xcarchive \
  DEVELOPMENT_TEAM=35373542G8
```

### Step 3 — Export and upload to App Store Connect

First, create `/tmp/ExportOptions.plist` if it doesn't exist:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store-connect</string>
    <key>teamID</key>
    <string>35373542G8</string>
    <key>destination</key>
    <string>upload</string>
    <key>signingStyle</key>
    <string>automatic</string>
</dict>
</plist>
```

Then export + upload in one command:

```bash
xcodebuild -exportArchive \
  -archivePath /tmp/SocialIQ.xcarchive \
  -exportOptionsPlist /tmp/ExportOptions.plist \
  -exportPath /tmp/SocialIQ-export \
  -allowProvisioningUpdates \
  -authenticationKeyPath ~/.appstoreconnect/private_keys/AuthKey_S6QR8N472U.p8 \
  -authenticationKeyID S6QR8N472U \
  -authenticationKeyIssuerID 8833fdf3-8efa-47a0-8777-442f8cc35999
```

Look for `** EXPORT SUCCEEDED **` and `Upload succeeded` in the output.

### Step 4 — Install on device

On the test iPhone, open the **TestFlight** app. The new build appears as an update. Tap **"Update"**.

## Important: Local changes vs TestFlight

Local code changes (editing Swift files, building for simulator) are NOT visible on TestFlight until the full deploy process above is completed. When making code changes intended for device testing, always explicitly tell the user: "These changes are local only — to test on your device, we need to archive and upload a new build." Don't assume the user knows this. After completing code changes, proactively offer to deploy.

## Temporary debug changes

When adding temporary debug code (e.g., skipping auth, forcing onboarding) to test locally, always revert before committing. Never commit `#if DEBUG` blocks that alter production flow unless intentional.

## Notes

- Export compliance is handled automatically — `ITSAppUsesNonExemptEncryption = NO` is set in the Xcode project, so no manual compliance resolution is needed in App Store Connect
- Build numbers must be strictly increasing — Apple rejects duplicates
- Superwall paywall config is server-side — paywall changes don't require a new build
- Archive timeout: allow ~3-5 minutes for the archive step
- Upload timeout: allow ~1-2 minutes for the export/upload step

## Fresh test on iPhone (reset Sign in with Apple)

After a successful deploy, always tell the user these steps if they want a fresh test of the build:

To get a completely fresh test of the TestFlight build (e.g., re-trigger onboarding, paywall, first-launch flows):

1. Open **Settings** on the iPhone
2. Use the **search bar** at the top, search for "Sign in with Apple"
3. Tap **Sign in with Apple**
4. Scroll to the bottom
5. Find **XC com jonathanchamberlin Social IQ**
6. Tap **Delete**
7. Tap **Stop Using**

This removes the Apple ID association so the next launch behaves like a first-time user.
