# Manual Setup Steps

These steps must be done in Xcode, the Supabase dashboard, or a terminal with sudo — they can't be automated via Claude Code.

## 0. Fix xcode-select Path

Run in Terminal (requires admin password):
```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```
Without this, `xcodebuild` won't work from the CLI.

## 1. Add Supabase Swift Package

1. Open `Social IQ.xcodeproj` in Xcode
2. File → Add Package Dependencies...
3. Paste URL: `https://github.com/supabase/supabase-swift`
4. Click "Add Package"
5. Select the `Supabase` library → Add to target "Social IQ"

## 2. Add SuperwallKit Package

1. File → Add Package Dependencies...
2. Paste URL: `https://github.com/superwall/Superwall-iOS`
3. Click "Add Package"
4. Select `SuperwallKit` library → Add to target "Social IQ"

## 3. Add Sign in with Apple Capability

1. Select the "Social IQ" project in the navigator
2. Select the "Social IQ" target
3. Go to Signing & Capabilities tab
4. Click "+ Capability"
5. Search for and add "Sign in with Apple"

## 4. Run SQL Migration in Supabase

1. Go to your Supabase project dashboard
2. Open the SQL Editor
3. Paste the contents of `supabase_migration.sql`
4. Click "Run"

## 5. Set Deployment Target to iOS 17.0

1. Select the "Social IQ" project in the navigator
2. Select the "Social IQ" target
3. General tab → Minimum Deployments → set iOS to 17.0

## 6. Remove iPad / Mac / Vision Targets

1. Select the "Social IQ" target
2. General tab → Supported Destinations
3. Remove "iPad", "Mac (Designed for iPad)", "Apple Vision (Designed for iPad)" if present
4. Keep only "iPhone"
