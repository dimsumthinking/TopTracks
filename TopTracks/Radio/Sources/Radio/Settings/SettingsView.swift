import SwiftUI
import ApplicationState

struct SettingsView: View {
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dismiss) private var dismiss
}

extension SettingsView {
  var body: some View {
    NavigationStack {
      List {
        ColorSchemeChooserView()
#if os(iOS)
        CellUsageSettingsView()
#endif
        InfoView()
      }
      
#if !os(macOS)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            dismiss()
          } label: {
            Text("Done")
          }
        }
      }
#endif
      .navigationTitle("Settings")
      .preferredColorScheme(currentColorScheme(from:  colorSchemeString) ?? colorScheme)
      
    }
  }
}
