import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func startPlaying() throws {
    let (station, context) = try background.station(from: self)
    station.lastTouched = Date()
    try context.save()
  }
  
  public func markPlayed(for song: Song) throws {
    let (station, context) = try background.station(from: self)
    guard let topTracksSong = station.topTracksSongMatching(song) else {return}
    topTracksSong.lastPlayed = Date()
    StationUpdatersLogger.markingSongAsPlayed.info("Marking \(topTracksSong.title) as played on station: \(station.stationName)")
    try context.save()
  }

}
