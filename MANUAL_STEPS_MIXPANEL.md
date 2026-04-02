# Adding Mixpanel Swift SDK via Xcode SPM

## Steps

1. Open `Social IQ.xcodeproj` in Xcode
2. File → Add Package Dependencies...
3. Paste the package URL: `https://github.com/mixpanel/mixpanel-swift`
4. Set dependency rule to "Up to Next Major Version" (current: 4.x)
5. Click "Add Package"
6. In the "Choose Package Products" dialog, check **Mixpanel** and set target to **Social IQ**
7. Click "Add Package"

## Verify

After adding, confirm `import Mixpanel` compiles in `Social IQ/Services/AnalyticsService.swift`.
