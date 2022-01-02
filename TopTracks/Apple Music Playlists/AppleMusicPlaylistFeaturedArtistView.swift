import SwiftUI

struct AppleMusicPlaylistFeaturedArtistView {
  let playlist: AppleMusicPlaylistBillboard
  @State private var names = ""
}

extension AppleMusicPlaylistFeaturedArtistView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(playlist.name)
        .font(.title3)
      Text(names)
        .font(.caption)
        .multilineTextAlignment(.leading)
        .lineLimit(3)
    }
    .padding()
    .onAppear {
      Task {try await loadNames()}
    }
  }
}

extension AppleMusicPlaylistFeaturedArtistView {
  private func loadNames() async throws {
    var result = ""
    let artists = try await  playlist.featuredArtists()
    for (index, artist) in artists.enumerated() {
      result.append(artist +
                    ((index < artists.count - 1) ? "," : "")
                    + ((index + 1).isMultiple(of: 3) ? "\n" : " "))
    }
    names = result
  }
}
