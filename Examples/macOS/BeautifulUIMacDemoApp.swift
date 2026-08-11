import BeautifulUICatalog
import SwiftUI

@main
struct BeautifulUIMacDemoApp: App {
    var body: some Scene {
        WindowGroup("BeautifulUI") {
            if ProcessInfo.processInfo.arguments.contains("--video-demo") {
                BeautifulUIVideoReel()
            } else {
                BeautifulUICatalog()
            }
        }
        .defaultSize(width: 1_260, height: 860)
    }
}
