import MusicKit

func shortenedNameFor(playlist: Playlist) -> String {
  playlist.name
    .replacingOccurrences(of: "Top 25: ", with: "")
    .replacingOccurrences(of: "Top 100:", with: "")
    .replacingOccurrences(of: "Daily 100:", with: "")
}


func filter(_ playlists: MusicItemCollection<Playlist>,
            using filterString: String) -> [Playlist] {
  let applePlaylists = playlists.filter {playlist in
    playlist.kind == .editorial
  }
  guard !filterString.isEmpty else {return applePlaylists}
  return applePlaylists.filter{$0.description.lowercased().contains(filterString.lowercased())}
}

