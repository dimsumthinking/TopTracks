import SwiftUI
import Constants

struct BillboardBackground: View {
  let backgroundColor: CGColor
  let isCurrentStation: Bool
  @Environment(\.colorScheme) var colorScheme
}

extension BillboardBackground {
  var body: some View {
    LinearGradient(colors: [ColorConstants.gradientStartColor(backgroundColor: backgroundColor,
                                                        colorScheme: colorScheme),
                            ColorConstants.gradientEndColor(backgroundColor: backgroundColor,
                                                            colorScheme: colorScheme)],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
    #if os(iOS)
    .border(isCurrentStation ? ColorConstants.accentColor(for: colorScheme) : .clear, width: 2)
    #endif
  }
}

//extension BillboardBackground: View {
//  var body: some View {
//    LinearGradient(colors: [Color(backgroundColor).opacity(0.9),
//                            Color(backgroundColor).opacity(0.2)],
//                   startPoint: .topLeading,
//                   endPoint: .bottomTrailing)
//      .border(isCurrentStation ? .yellow : .clear, width: 2)
//  }
//}

