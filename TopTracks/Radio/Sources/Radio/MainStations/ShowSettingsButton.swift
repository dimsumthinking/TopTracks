import SwiftUI

struct ShowSettingsButton: View {
  @Binding var mainStationsSheet: MainStationsSheet?
}

extension ShowSettingsButton {
  var body: some View {
    Button {
      mainStationsSheet = .settings
    } label: {
      Image(systemName: "gear")
    }
  }
}
