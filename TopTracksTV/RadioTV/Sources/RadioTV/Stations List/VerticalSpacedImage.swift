import SwiftUI

struct VerticalSpacedImage {
  let systemName: String
}

extension VerticalSpacedImage: View {
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: systemName)
      Spacer()
    }
  }
}

