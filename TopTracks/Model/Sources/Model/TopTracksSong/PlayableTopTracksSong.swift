//import MusicKit
//import Foundation
//import CoreData
//
//public struct PlayableTopTracksSong {
//  public let song: Song
//  public let artwork: Artwork
//  public let id: MusicItemID
//  public let topTracksSongID: UUID
//  
//  init?(topTracksSong: TopTracksSong) {
//    guard let song = topTracksSong.song,
//          let artwork = song.artwork else { return nil }
//    self.song = song
//    self.artwork = artwork
//    self.topTracksSongID = topTracksSong.id
//    self.id = song.id
//  }
//}
//
//extension PlayableTopTracksSong {
//  public func updateLastPlayedDate() {
//    let request = TopTracksSong.fetchRequest()
//    request.predicate = NSPredicate(format: "id == %@", topTracksSongID as CVarArg)
//    do {
//      let matchingSongs = try PersistenceController.newBackgroundContext.fetch(request)
//      if let topTracksSong = matchingSongs.first {
//        topTracksSong.lastPlayed = Date()
//      }
//    } catch {
//      print("Failed to return from search")
//    }
//  }
//}
//
//extension PlayableTopTracksSong: PlayableMusicItem {
//  public var playParameters: PlayParameters? {
//    song.playParameters
//  }
//}
