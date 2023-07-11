import SwiftUI
import Constants

struct BillboardBackground {
  let backgroundColor: CGColor
  let isCurrentStation: Bool
  @Environment(\.colorScheme) var colorScheme
}

extension BillboardBackground: View {
  var body: some View {
    LinearGradient(colors: [ColorConstants.gradientStartColor(backgroundColor: backgroundColor,
                                                        colorScheme: colorScheme),
                            ColorConstants.gradientEndColor(backgroundColor: backgroundColor,
                                                            colorScheme: colorScheme)],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
    #if !os(tvOS)
    .border(isCurrentStation ? ColorConstants.accentColor(for: colorScheme) : .clear, width: 2)
    #endif
  }
}
