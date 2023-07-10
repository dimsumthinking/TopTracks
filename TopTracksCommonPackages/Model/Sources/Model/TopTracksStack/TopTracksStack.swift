import Foundation
import SwiftData
import MusicKit


@Model public class TopTracksStack {
    var name: String = RotationCategory.medium.description
    
    @Relationship(inverse: \TopTracksSong.stack) public var songs: [TopTracksSong]?
    var station: TopTracksStation?
    
    init(category: RotationCategory,
                     songs: [Song],
                     station: TopTracksStation) {
      self.name = category.name
      self.station = station
      self.songs = topTrackSongs(songs: songs)
      print(name, ":  \n", songs.map(\.title))
    }
}

extension TopTracksStack {
  var rotationCategory: RotationCategory {
    guard let category = RotationCategory(rawValue: name) else {
      fatalError("No Rotation Category corresponds to this stack - which shouldn't be possible")
    }
    return category
  }
  
 public var orderedSongs: [TopTracksSong] {
    songs?.sorted {$0.lastPlayed < $1.lastPlayed} ?? [TopTracksSong]()
  }
}


extension TopTracksStack {
  private func topTrackSongs(songs: [Song]) -> [TopTracksSong] {
    var topTracksSongs = [TopTracksSong]()
    for song in songs {
      topTracksSongs.append(TopTracksSong(song: song,
                                          stack: self))
    }
    return topTracksSongs
  }
}
