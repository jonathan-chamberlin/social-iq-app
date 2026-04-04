---
name: testflight-deploy
description: Archive, upload, and deploy a new build to TestFlight for Social IQ. Trigger on: "testflight", "deploy", "upload build", "new build", "archive".
---

# TestFlight Deploy for Social IQ

## App Store Connect details

- **App:** Social IQ - Charisma Training
- **Bundle ID:** com.jonathanchamberlin.Social-IQ
- **Team ID:** 35373542G8
- **App Store Connect URL:** https://appstoreconnect.apple.com/teams/8833fdf3-8efa-47a0-8777-442f8cc35999/apps/6761561557/testflight/ios
- **Internal testing group:** Dev Testing (auto-receives builds after compliance is resolved)

## Full deploy process

### Step 1 — Bump build number

Before archiving, increment `CURRENT_PROJECT_VERSION` in the Xcode project. Do NOT modify .pbxproj directly — use:

```bash
cd /Users/jonathanchamberlin/repos/social-iq
agvtool new-version -all <next_build_number>
```

### Step 2 — Archive in Xcode

1. Open `Social IQ.xcodeproj` in Xcode
2. Top bar → select **"Social IQ" > "Any iOS Device (arm64)"** as destination (NOT a simulator)
3. Menu: **Product → Archive**
4. Wait for Organizer window to open

### Step 3 — Upload to App Store Connect

1. In the Organizer, select the new archive → click **"Distribute App"**
2. Choose **"App Store Connect"** → click **Next**
3. Choose **"Upload"** (not Export) → click **Next**
4. Leave all checkboxes default → click **Next**
5. Select signing certificate (Team: 35373542G8) → click **Upload**
6. Wait ~5-15 minutes for Apple to process (you'll get an email)

### Step 4 — Resolve compliance and add to testing group

This is done in App Store Connect (browser). Generate a Claude Chrome prompt or do manually:

1. Go to TestFlight tab → left sidebar → click **"iOS"** under Builds
2. Scroll to the **"Version 1.0"** builds table, find the new build
3. If it shows a "Missing Compliance" warning, click **"Manage"** next to it
4. Select **"None of the algorithms mentioned above"** → click **"Save"**
5. Status changes to "Ready to Submit"
6. Resolving compliance auto-adds the build to "Dev Testing" group

**If Dev Testing is NOT auto-added:** Click the **build number link** in the BUILD column to open the build detail page. Find the **"Group"** section, click **"+"**, select **"Dev Testing"**, click **"Add"**.

### Step 5 — Install on device

On the test iPhone, open the **TestFlight** app. The new build should appear as an update. Tap **"Update"**.

## Claude Chrome prompt template

When the user needs a prompt for Chrome automation to handle Step 4:

```
I'm on App Store Connect in the TestFlight tab for "Social IQ". I need to resolve compliance for Build N and add it to testing.

1. In the left sidebar under "Builds", click "iOS"
2. In the "Version 1.0" builds table, find Build N
3. If it shows "Missing Compliance", click "Manage" next to it
4. Select "None of the algorithms mentioned above" and click "Save"
5. Click the build number link to open the build detail page
6. Check if "Dev Testing" appears in the Group section — if not, click "+", select "Dev Testing", click "Add"
```

## Notes

- The app uses only HTTPS (exempt encryption) — always select "None of the algorithms mentioned above" for compliance
- Build numbers must be strictly increasing — Apple rejects duplicates
- No fastlane auth is configured — all App Store Connect actions are manual or via Claude Chrome
- Superwall paywall config is server-side — paywall changes don't require a new build
