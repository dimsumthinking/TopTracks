import SwiftUI
import Constants

struct CurrentStationIndicator {
  @Environment(\.colorScheme) private var colorScheme
}

extension CurrentStationIndicator: View {
  var body: some View {
    HStack {
      Spacer()
      
      Image(systemName: "antenna.radiowaves.left.and.right")
        .padding(.trailing)
        .font(.largeTitle)
        .foregroundColor(ColorConstants.accentColor(for: colorScheme))
    }
  }
}
