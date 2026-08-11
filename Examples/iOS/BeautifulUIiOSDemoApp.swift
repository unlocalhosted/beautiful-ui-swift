import BeautifulUICatalog
import SwiftUI

@main
struct BeautifulUIiOSDemoApp: App {
    private var videoSection: CatalogSection? {
        let arguments = ProcessInfo.processInfo.arguments
        guard let flagIndex = arguments.firstIndex(of: "--video-section"),
              arguments.indices.contains(flagIndex + 1) else {
            return nil
        }
        return CatalogSection(rawValue: arguments[flagIndex + 1])
    }

    var body: some Scene {
        WindowGroup {
            if let videoSection {
                BeautifulUIVideoReel(section: videoSection)
            } else if ProcessInfo.processInfo.arguments.contains("--video-demo") {
                BeautifulUIVideoReel()
            } else {
                BeautifulUICatalog()
            }
        }
    }
}
