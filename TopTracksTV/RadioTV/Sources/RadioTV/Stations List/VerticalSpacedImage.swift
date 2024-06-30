import SwiftUI

struct VerticalSpacedImage: View {
  let systemName: String
}

extension VerticalSpacedImage {
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: systemName)
      Spacer()
    }
  }
}

