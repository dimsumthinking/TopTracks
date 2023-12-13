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
    topTracksSong.rating = rating.name
    topTracksSong.lastPlayed = Date()
    try context.save()
  }
}
