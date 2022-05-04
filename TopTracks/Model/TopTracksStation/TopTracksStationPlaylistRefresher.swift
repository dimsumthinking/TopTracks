import MusicKit
import CoreData

extension TopTracksStation {
  var playlistNeedsRefreshing: Bool {
    guard stationType == .playlist else {return false}
    return (Date().timeIntervalSince(lastRefreshed)) > 24 * 60 * 60 // check for update daily
  }
}

extension TopTracksStation {
  func refreshPlaylist() async {
    guard let playlistIDString = playlistInfo?.playlistID,
          let playlist = await playlist(with: MusicItemID(playlistIDString)),
          let context = managedObjectContext else {return}
    guard lastRefreshed < (playlist.lastModifiedDate ?? Date().addingTimeInterval(-7 * 24 * 60 * 60)) else {return}
    let notRatedStack = stack(.notRated) ?? TopTracksStack(rotationCategory: .notRated,
                                                           songs: [Song](),
                                                           station: self,
                                                           context: context)
    await notRatedStack.add(songsForRefresher(for: playlist),
                            context: context)
    lastRefreshed = Date()
    try? context.save()
    
  }
}

extension TopTracksStation {
  private func playlist(with musicItemID: MusicItemID) async -> Playlist? {
    let request = MusicCatalogResourceRequest<Playlist>(matching: \.id,
                                                        equalTo: musicItemID)
    return try? await request.response().items.first
  }
  
  private func songsForRefresher(for playlist: Playlist) async -> [Song] {
    async let results = playlist.with([.tracks])
    guard let tracks = try? await results.tracks else  {return [Song]()}
    return tracks
      .compactMap(songWithArtwork)
      .filter{song in !allSongTitles.contains(song.title)}
  }
}

extension TopTracksStation {
  private func songWithArtwork(from track: Track) -> Song? {
    guard case Track.song(let song) = track else {return nil}
    guard song.artwork != nil else {return nil}
    return song
  }
  
  private var allSongTitles: [String] {
    stacks.flatMap{stack in stack.songs}.map(\.title)
  }
}


