import SwiftUI

struct AppleMusicFeaturedArtistView {
  let artists: [String]
}

extension AppleMusicFeaturedArtistView: View {
    var body: some View {
        Text(names)
        .font(.caption)
        .multilineTextAlignment(.leading)
        .lineLimit(3)
    }
}

extension AppleMusicFeaturedArtistView {
  private var names: String {
    var result = ""
    for (index, artist) in artists.enumerated() {
      result.append(artist + ","
                    + ((index + 1).isMultiple(of: 3) ? "\n" : " "))
    }
    return result
  }
}

struct AppleMusicFeaturedArtistView_Previews: PreviewProvider {
    static var previews: some View {
        AppleMusicFeaturedArtistView(artists: [""])
    }
}
