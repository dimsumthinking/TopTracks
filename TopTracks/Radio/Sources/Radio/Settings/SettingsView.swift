import SwiftUI
import ApplicationState

struct SettingsView: View {
  @Binding var mainStationsSheet: MainStationsSheet?
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @Environment(\.colorScheme) private var colorScheme
}

extension SettingsView {
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
            mainStationsSheet = nil
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
