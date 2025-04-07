import SwiftUI
import Model
import SwiftData

struct StationNameView: View {
  let name: String
  let playbackFailed: Bool
}

extension StationNameView {
  var body: some View {
    VStack {
      Spacer()
      Text(name)
        .strikethrough(playbackFailed, color: .red)
        .padding(.horizontal, 8)
        .multilineTextAlignment(.leading)
        .lineLimit(3)
        .font(.headline)
      Spacer()
    }
  }
}

#Preview {
  StationNameView(name: "90's Rock Classics",
                  playbackFailed: true)
}
