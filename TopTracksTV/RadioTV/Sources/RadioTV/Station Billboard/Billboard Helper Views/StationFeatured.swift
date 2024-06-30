import SwiftUI

struct StationFeatured: View {
  let featured: String
}

extension StationFeatured {
  var body: some View {
    Text(featured)
      .font(.caption)
      .multilineTextAlignment(.leading)
      .foregroundColor(.secondary)
      .lineLimit(3)
  }
}
