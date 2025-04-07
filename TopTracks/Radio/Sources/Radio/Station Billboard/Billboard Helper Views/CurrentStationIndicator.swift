import SwiftUI
import Constants

struct CurrentStationIndicator: View {
  @Environment(\.colorScheme) private var colorScheme
  let isCurrentStation: Bool
}

extension CurrentStationIndicator {
  var body: some View {
    Image(systemName: "antenna.radiowaves.left.and.right")
      .padding(.trailing)
      .font(.largeTitle)
      .foregroundStyle(isCurrentStation ? ColorConstants.accentColor(for: colorScheme) : .clear)
  }
}
