import SwiftUI

struct BillboardBackground {
  let backgroundColor: CGColor
  let isCurrentStation: Bool
}

extension BillboardBackground: View {
  var body: some View {
    LinearGradient(colors: [Color(backgroundColor).opacity(0.9), Color(backgroundColor).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
      .border(isCurrentStation ? .yellow : .clear)
  }
}

