import SwiftUI

struct ShowInfoButton: View {
  @Binding var mainStationsSheet: MainStationsSheet?
}

extension ShowInfoButton {
  var body: some View {
    Button {
      mainStationsSheet = .info
    } label: {
      Image(systemName: "info.circle")
    }
  }
}
