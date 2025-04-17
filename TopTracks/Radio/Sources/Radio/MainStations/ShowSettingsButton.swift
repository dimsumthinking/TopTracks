import SwiftUI

struct ShowSettingsButton: View {
  @Binding var isShowingSettings: Bool
}

extension ShowSettingsButton {
  var body: some View {
    Button {
      isShowingSettings = true
    } label: {
      Image(systemName: "gear")
    }
  }
}
