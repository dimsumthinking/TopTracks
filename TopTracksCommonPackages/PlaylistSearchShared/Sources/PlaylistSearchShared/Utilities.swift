import MusicKit

public func shortenedNameFor(playlist: Playlist) -> String {
  playlist.name
    .replacingOccurrences(of: "Top 25: ", with: "")
    .replacingOccurrences(of: "Top 100:", with: "")
    .replacingOccurrences(of: "Daily 100:", with: "")
}

public func filter(_ playlists: MusicItemCollection<Playlist>,
            using filterString: String,
            playlistKind: PlaylistKind = .openSearch,
            appleOnly: Bool = true) -> [Playlist] {
  var playlists = playlists.filter {playlist in
    appleOnly ? playlist.kind == .editorial : true
  }
  playlists = playlists.filter {playlist in
    guard let shortDescription = playlist.shortDescription else {return true}
    return playlistKind == .moodAndActivity ? shortDescription.starts(with: "Hey Siri") : true
  }
  guard !filterString.isEmpty else {return playlists}
  return playlists.filter{$0.description.lowercased().contains(filterString.lowercased())}
}


