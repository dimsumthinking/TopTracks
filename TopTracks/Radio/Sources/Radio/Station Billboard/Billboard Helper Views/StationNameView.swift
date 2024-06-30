import SwiftUI
import Model
import SwiftData

struct StationNameView: View {
  let name: String
  let isCurrentStation: Bool
}

extension StationNameView {
  var body: some View {
    HStack {
      if !isCurrentStation {
        Spacer()
      }
      
      Text(name)
        .padding(.trailing, 8)
        .multilineTextAlignment(isCurrentStation ? .trailing : .leading)
        .lineLimit(3)
        .font(.headline)
    }
  }
}

#Preview {
  StationNameView(name: "90's Rock Classics",
                  isCurrentStation: true)
}
