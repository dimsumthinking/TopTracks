import SwiftUI

struct SettingsView {
  @Binding var isShowingSettings: Bool
}

extension SettingsView: View {
  var body: some View {
    VStack(spacing: 50) {
    Text("Settings not implemented yet")
      Button("Dismiss",
             role: .cancel){
        isShowingSettings = false
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(isShowingSettings: .constant(true))
  }
}
