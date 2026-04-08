---
name: app-store-screenshots
description: Capture and crop simulator screenshots for App Store submission
trigger: "screenshot for app store", "app store screenshot", "capture screenshot"
---

# App Store Screenshots

## Steps

1. **Take screenshot** from simulator:
   ```bash
   xcrun simctl io F9A3AAE0-306C-412C-AA3F-491BD795870A screenshot "/Users/jonathanchamberlin/repos/social-iq/App Store Screenshots/<set>/<name>.png"
   ```

2. **Crop to App Store size** (1242x2688):
   ```bash
   python3 .claude/scripts/crop-screenshots.py "App Store Screenshots/<set>"
   ```

3. **Copy to Downloads** for upload:
   ```bash
   rm -rf ~/Downloads/<set>
   cp -r "App Store Screenshots/<set>" ~/Downloads/<set>
   ```

## Folder structure

```
App Store Screenshots/
  1/    — first set of screenshots
  2/    — second set, etc.
```

## Accepted sizes

- 6.5": 1242x2688 or 2688x1242 (landscape)
- 6.7": 1284x2778 or 2778x1284 (landscape)

Script currently targets 1242x2688 from iPhone 17 Pro simulator (1206x2622).
