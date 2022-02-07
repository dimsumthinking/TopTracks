import MusicKit
import Foundation

extension TopTracksSong: PlayableMusicItem {
  public var id: MusicItemID {
    guard let song = song else {fatalError("TopTracksSong must contain song")}
    return song.id
  }
  
  public var playParameters: PlayParameters? {
    guard let song = song else {fatalError("TopTracksSong must contain song")}
    return song.playParameters
  }
}
