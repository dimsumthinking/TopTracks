import MusicKit
import Foundation


public func fetchPlaylist(for url: URL) async throws -> Playlist {
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


public enum PlaylistImportError {
  case badlyFormedURL(url: URL)
  case unknownPlaylistType(type: String)
  case playlistNotFound(playlistID: String)
}

public struct BadlyFormedURL: Error {
  public let url: URL
}

public struct UnKnownPlaylistType: Error {
  public let host: String
}

public struct PlaylistNotFound: Error {
  public let playlistId: String
}
