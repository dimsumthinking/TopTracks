import SwiftUI

struct ShowSettingsButton {
  @Binding var mainStationsSheet: MainStationsSheet?
}

extension ShowSettingsButton: View {
  var body: some View {
    Button {
      mainStationsSheet = .settings
    } label: {
      Image(systemName: "gear")
    }
  }
}
