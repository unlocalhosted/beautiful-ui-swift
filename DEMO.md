# BeautifulUI live demo gallery

Every preview below plays directly on this GitHub page. GitHub sanitizes inline MP4 players in repository Markdown, so each animated GIF links to its full-quality native MP4 release.

Every capture comes from native SwiftUI in the iPhone demo app. No web view. No browser recording.

[Download complete 81-second reel](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/BeautifulUI-Primitives-Demo.mp4)

| 01 · Loading State | 02 · Thinking |
| --- | --- |
| [![Loading State animated preview](Media/Previews/01-Loading-State.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/01-Loading-State.mp4) | [![Thinking animated preview](Media/Previews/02-Thinking.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/02-Thinking.mp4) |
| 03 · Streaming Text | 04 · Approval Card |
| [![Streaming Text animated preview](Media/Previews/03-Streaming-Text.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/03-Streaming-Text.mp4) | [![Approval Card animated preview](Media/Previews/04-Approval-Card.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/04-Approval-Card.mp4) |
| 05 · Tool Chips | 06 · Task Rows |
| [![Tool Chips animated preview](Media/Previews/05-Tool-Chips.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/05-Tool-Chips.mp4) | [![Task Rows animated preview](Media/Previews/06-Task-Rows.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/06-Task-Rows.mp4) |
| 07 · Chat | 08 · Prompt Bar |
| [![Chat animated preview](Media/Previews/07-Chat.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/07-Chat.mp4) | [![Prompt Bar animated preview](Media/Previews/08-Prompt-Bar.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/08-Prompt-Bar.mp4) |
| 09 · Recommendation Card | 10 · Context Cards |
| [![Recommendation Card animated preview](Media/Previews/09-Recommendation-Card.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/09-Recommendation-Card.mp4) | [![Context Cards animated preview](Media/Previews/10-Context-Cards.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/10-Context-Cards.mp4) |
| 11 · Diff Table | 12 · Records Table |
| [![Diff Table animated preview](Media/Previews/11-Diff-Table.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/11-Diff-Table.mp4) | [![Records Table animated preview](Media/Previews/12-Records-Table.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/12-Records-Table.mp4) |
| 13 · Filter Table | 14 · Sidebar Nav |
| [![Filter Table animated preview](Media/Previews/13-Filter-Table.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/13-Filter-Table.mp4) | [![Sidebar Nav animated preview](Media/Previews/14-Sidebar-Nav.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/14-Sidebar-Nav.mp4) |
| 15 · Search | 16 · Insight Cards |
| [![Search animated preview](Media/Previews/15-Search.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/15-Search.mp4) | [![Insight Cards animated preview](Media/Previews/16-Insight-Cards.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/16-Insight-Cards.mp4) |
| 17 · Code Block | 18 · Fine-tune Card |
| [![Code Block animated preview](Media/Previews/17-Code-Block.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/17-Code-Block.mp4) | [![Fine-tune Card animated preview](Media/Previews/18-Fine-Tune-Card.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/18-Fine-Tune-Card.mp4) |
| 19 · Selection Actions | |
| [![Selection Actions animated preview](Media/Previews/19-Selection-Actions.gif)](https://github.com/unlocalhosted/beautiful-ui-swift/releases/download/0.2.2/19-Selection-Actions.mp4) | |

## Regenerate previews

Capture MP4 clips from the native iPhone demo, then run:

```sh
bash Scripts/generate-github-previews.sh /path/to/mp4-clips
```

The generated GIFs are intentionally small, loop forever, and are checked into `Media/Previews` so GitHub can render them without an external player.
