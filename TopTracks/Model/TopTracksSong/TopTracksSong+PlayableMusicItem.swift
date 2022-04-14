import MusicKit
import CoreData
//
//extension TopTracksSong: PlayableMusicItem {
//  public var playParameters: PlayParameters? {
//    guard let song = song else {fatalError("TopTracksSong must contain Song")}
//    return song.playParameters
//  }
//  
//  public var id: MusicItemID {
//    guard let song = song else {fatalError("TopTracksSong must contain Song")}
//    return song.id
//  }
//}
//
extension TopTracksSong {
  static func artwork(for song: Song) -> Artwork? {
    let request = TopTracksSong.fetchRequest()
    request.predicate = NSPredicate(format: "%K == %@", #keyPath(TopTracksSong.songID), song.id.rawValue)
    return try? sharedViewContext.fetch(request).first?.artwork
  }
}
