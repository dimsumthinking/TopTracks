import MusicKit
import SwiftUI

struct AppleMusicPlaylistBillboard {
  let playlist: Playlist
}

extension AppleMusicPlaylistBillboard {
  var artwork: Artwork? {
    playlist.artwork
  }
  
  var name: String {
    playlist.name
  }
  
  var backgroundColor: Color {
    artwork?.backgroundColor.map(Color.init(cgColor:)) ?? .secondary
  }
  
  var textColor: Color {
    artwork?.secondaryTextColor.map(Color.init(cgColor:)) ?? .yellow
  }
  
  func featuredArtists() async throws -> [String] {
    let artistsPlaylist = try await playlist.with([.featuredArtists])
    guard let artists = artistsPlaylist.featuredArtists  else {return [""]}
    return artists.map(\.name)
  }
}
