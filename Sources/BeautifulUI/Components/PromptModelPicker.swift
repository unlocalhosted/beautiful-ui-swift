import SwiftUI

struct PromptModelPicker: View {
    let models: [String]
    @Binding var selectedModel: String

    var body: some View {
        if !models.isEmpty {
            Menu("Choose model", systemImage: "slider.horizontal.3") {
                Picker("Model", selection: $selectedModel) {
                    ForEach(models, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(BeautifulIconButtonStyle())
        }
    }
}
