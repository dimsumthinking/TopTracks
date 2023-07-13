import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func add(songs songsToAdd: [Song]) {
    var added: TopTracksStack
    if let addedStack = stack(for: .added) {
      added = addedStack
    } else {
      added = TopTracksStack(category: .added,
                             songs: [Song](),
                             station: self)
      do {
        try context?.save()
        stationLastUpdated = Date()
      } catch {
        print("Couldn't add added stack")
      }
    }
    
    
    let ids = availableSongs.map(\.songID)
    for song in songsToAdd {
      if !ids.contains(song.id.rawValue) {
        added.songs?.append(TopTracksSong(song: song,
                                          stack: added))
      }
    }
    do {
    try context?.save()
  } catch {
    print("Couldn't save after adding songs to playlist")
  }
}

}





