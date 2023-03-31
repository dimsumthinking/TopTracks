import SwiftUI

struct StationFeatured {
  let featured: String
}

extension StationFeatured: View {
  var body: some View {
    Text(featured)
      .font(.caption)
      .multilineTextAlignment(.leading)
      .foregroundColor(.secondary)
      .lineLimit(3)
  }
}
