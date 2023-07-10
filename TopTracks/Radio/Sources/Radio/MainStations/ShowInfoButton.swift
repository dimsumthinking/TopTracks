import SwiftUI

struct ShowInfoButton {
  @Binding var mainStationsSheet: MainStationsSheet?
}

extension ShowInfoButton: View {
  var body: some View {
    Button {
      mainStationsSheet = .info
    } label: {
      Image(systemName: "info.circle")
    }
  }
}
