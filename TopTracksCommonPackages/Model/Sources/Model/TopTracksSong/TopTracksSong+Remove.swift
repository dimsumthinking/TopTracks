import SwiftData
import Foundation

extension TopTracksSong {
  public func remove() throws {
    let (topTracksSong, context) = try background.song(from: self)
    context.delete(topTracksSong)
    try context.save()
  }
  
  public func changeRating(to rating: SongRating) throws {
    let (topTracksSong, context) = try background.song(from: self)
    topTracksSong.rating = rating.description
    topTracksSong.lastPlayed = Date()
    try context.save()
    StationUpdatersLogger.changedSongRating.info("Changed rating of \(topTracksSong.title) to \(rating.name)")
  }
}
