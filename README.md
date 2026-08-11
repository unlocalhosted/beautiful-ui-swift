# BeautifulUI

Pixel-precise SwiftUI primitives for AI-native interfaces.

BeautifulUI brings the visual language of [Beautiful UI](https://beautiful-ui-five.vercel.app/) to native Apple platforms: same compact type scale, neutral surfaces, hairline structure, low-key motion, and deliberate human-in-the-loop controls. It is a SwiftUI implementation, not a web view or a port of React runtime code.

## Platforms

- iOS 26+
- macOS 26+
- Swift 6.3+
- Apple frameworks only

## Install

Add BeautifulUI as a Swift Package dependency in Xcode, then import it:

```swift
import BeautifulUI
```

Use the first stable tag in `Package.swift`:

```swift
.package(url: "https://github.com/unlocalhosted/beautiful-ui-swift.git", from: "0.2.2")
```

## Start

```swift
import BeautifulUI

RecommendationCard(
    recommendation: .init(
        title: "Ready to restock?",
        summary: "Waffle cones will reach reorder point in 7 days.",
        confidence: .high
    ),
    onAccept: placeOrder,
    onAlternatives: showAlternatives
)
```

## Primitives

- Agent execution: `LoadingStateView`, `ThinkingTraceView`, `ToolCallGroup`, `AgentTaskList`
- Conversation: `StreamingResponseView`, `ChatPanel`, `PromptBar`, `ApprovalCard`
- Decision support: `RecommendationCard`, `ContextChunkCard`, `InsightCard`, `ChangeTable`
- Workspaces: `RecordTable`, `FilterableTaskTable`, `WorkspaceSidebar`, `CommandSearch`
- Authoring: `CodeBlock`, `FineTuneCard`, `SelectionActions`

## Theming

Every primitive receives `BeautifulTheme` through SwiftUI environment values. `BeautifulTheme.reference` is default and matches reference dark mode. Use `BeautifulTheme.referenceLight` for reference light mode.

```swift
YourAgentScreen()
    .environment(\.beautifulTheme, .referenceLight)
```

## Principles

BeautifulUI does not fetch data, manage agent state, copy to clipboard, or decide whether an agent may act. Your application owns data, permissions, confirmation rules, persistence, and external effects. Library controls communicate intent through state bindings and closures.

## Catalogue apps

`BeautifulUICatalog` is a native visual catalogue, included in both demo apps. It is deliberately responsive rather than a web wrapper: macOS uses a 960-point document shell and persistent 288-point rail; iPhone uses a compact header, horizontal component rail, and full-width demo stages.

```sh
xcodegen generate
open BeautifulUI.xcodeproj
```

## Demo reel

The native iPhone reel shows all 19 primitives in sequence, including their live source-faithful motion states.

[Download the 81-second MP4 demo](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/BeautifulUI-Primitives-Demo.mp4)

Run either demo app with `--video-demo` to render the same full-screen reel locally. On iOS, `--video-section loading` renders a single named primitive for clip capture.

[Browse every per-primitive demo clip](DEMO.md)

## Development

```sh
swift test
xcodegen generate
```

The repository includes native iOS and macOS demos. Before a release, verify both app targets and the Swift Package tests.

## Open source

BeautifulUI is released under the [MIT License](LICENSE). Contributions follow [CONTRIBUTING.md](CONTRIBUTING.md). Security concerns should not be filed in public issues; see [SECURITY.md](SECURITY.md).

The original web catalogue remains its creators’ work. This project independently implements its documented visual language in SwiftUI for Apple platforms.
