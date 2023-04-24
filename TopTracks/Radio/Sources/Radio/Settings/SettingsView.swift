import SwiftUI
import ApplicationState

struct SettingsView {
  @Binding var isShowingSettings: Bool
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @Environment(\.colorScheme) private var colorScheme
}

extension SettingsView: View {
  var body: some View {
    NavigationStack {
      VStack {
        List {
          ColorSchemeChooserView()
          #if os(iOS)
          CellUsageSettingsView()
          #endif
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            isShowingSettings = false
          } label: {
            Text("Done")
          }
        }
      }
      .navigationTitle("Settings")
          .preferredColorScheme(currentColorScheme(from:  colorSchemeString) ?? colorScheme)

    }
  }
}
