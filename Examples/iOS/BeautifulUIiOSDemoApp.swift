import BeautifulUICatalog
import SwiftUI

@main
struct BeautifulUIiOSDemoApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("--video-demo") {
                BeautifulUIVideoReel()
            } else {
                BeautifulUICatalog()
            }
        }
    }
}
