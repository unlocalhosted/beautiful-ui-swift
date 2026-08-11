# Contributing to BeautifulUI

## Scope

Keep primitives small, data-owned by the host, and usable on iPhone, iPad, and macOS. Do not add networking, global agent state, analytics, or policy decisions to the library.

## Visual contract

Changes must preserve reference fidelity:

- compact 11–13 point component type scale
- 6, 8, and 10 point component radii
- hairline borders for structure, not heavy elevation
- dark and light reference themes
- reduced-motion-safe interaction feedback

## Before opening a pull request

```sh
swift test
xcodegen generate
xcodebuild -project BeautifulUI.xcodeproj -scheme BeautifulUIMacDemo -configuration Debug -destination 'platform=macOS,arch=arm64' build CODE_SIGNING_ALLOWED=NO
xcodebuild -project BeautifulUI.xcodeproj -scheme BeautifulUIiOSDemo -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build CODE_SIGNING_ALLOWED=NO
```

Include screenshots or a short screen recording for visual changes. Test dark mode, light mode, Dynamic Type, VoiceOver labels, and Reduce Motion when relevant.

## Pull request shape

One coherent primitive, fix, or documentation change per pull request. Explain the host-owned data and action contract for new public APIs. Add tests for deterministic model or filtering behavior.
