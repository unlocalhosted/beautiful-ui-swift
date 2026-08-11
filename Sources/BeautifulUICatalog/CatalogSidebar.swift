import SwiftUI

struct CatalogSidebar: View {
    @Binding var selection: CatalogSection?

    var body: some View {
        List(selection: $selection) {
            Section {
                CatalogIdentity()
            }
            Section("Components") {
                ForEach(CatalogSection.allCases) { section in
                    NavigationLink(value: section) {
                        Text(section.title)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("BeautifulUI")
    }
}
