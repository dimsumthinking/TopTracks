import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func startPlaying() throws {
    let context = backgroundModelActor.context
    guard let station = context.model(for: self.persistentModelID) as? TopTracksStation else {return}
    station.lastTouched = Date()
    try context.save()
  }
  
  public func markPlayed(for song: Song) throws {
    let context = backgroundModelActor.context
    guard let station = context.model(for: self.persistentModelID) as? TopTracksStation,
    let topTracksSong = station.topTracksSongMatching(song) else {return}
    
    topTracksSong.lastPlayed = Date()
    try context.save()
  }

}
