import Foundation
import SwiftData
import MusicKit


@Model public class TopTracksStack {
    var name: String = RotationCategory.medium.description
    
    @Relationship(inverse: \TopTracksSong.stack) public var songs: [TopTracksSong]? = [TopTracksSong]()
    public var station: TopTracksStation?
  
  public init(category: RotationCategory) {
    self.name = category.name
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
      let topTracksSong = TopTracksSong(song: song)
      topTracksSongs.append(topTracksSong)
      topTracksSong.stack = self
    }
    return topTracksSongs
  }
}
