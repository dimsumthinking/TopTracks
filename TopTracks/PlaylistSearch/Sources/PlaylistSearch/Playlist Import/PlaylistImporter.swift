import MusicKit
import Foundation


func fetchPlaylist(for url: URL) async throws -> Playlist {
  let components = URLComponents(url: url,
                                 resolvingAgainstBaseURL: true)
  guard let host = components?.host,
        let musicIDString = components?.queryItems?.first?.value else { throw BadlyFormedURL(url: url) }
  guard host == "playlist" else {throw UnKnownPlaylistType(host: host)}
  let request = MusicCatalogResourceRequest<Playlist>(matching: \.id,
                                                      equalTo: MusicItemID(musicIDString))
  let response = try await request.response()
  
  guard let playlist = response.items.first else {
    throw PlaylistNotFound(playlistId: musicIDString)
  }
  return playlist
}


enum PlaylistImportError {
  case badlyFormedURL(url: URL)
  case unknownPlaylistType(type: String)
  case playlistNotFound(playlistID: String)
}

struct BadlyFormedURL: Error {
  let url: URL
}

struct UnKnownPlaylistType: Error {
  let host: String
}
struct PlaylistNotFound: Error {
  let playlistId: String
}
