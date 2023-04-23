import CoreData
import MusicKit

extension TopTracksStation {
  public func add(songs songsToAdd: [Song],
                  for playlist: Playlist) {
    guard let managedObjectContext,
          let added = stack(for: .added) else { return }
    let ids = availableSongs.map(\.songID)
    songsToAdd.forEach { song in
      guard ids.contains(song.id.rawValue) else { return }
      added.songs.insert(TopTracksSong(song: song,
                                       stack: added,
                                       context: managedObjectContext))
    }
    saveIfPossible()
  }
  
}



