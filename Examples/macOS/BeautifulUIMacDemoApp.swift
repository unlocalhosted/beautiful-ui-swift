import BeautifulUICatalog
import SwiftUI

@main
struct BeautifulUIMacDemoApp: App {
    var body: some Scene {
        WindowGroup("BeautifulUI") {
            BeautifulUICatalog()
        }
        .defaultSize(width: 1_260, height: 860)
    }
}
