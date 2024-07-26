import SwiftData
import Foundation



@ModelActor public actor CurrentSongUpdater {}

extension CurrentSongUpdater {
  public init() {
    self.init(modelContainer: CommonContainer.shared.container)
  }
}

@MainActor
extension CurrentSongUpdater {
  public func markPlayed(songWithID: PersistentIdentifier) {
    let context = CommonContainer.shared.container.mainContext
    if let song =  context.model(for: songWithID) as? TopTracksSong {
      song.lastPlayed = Date()
      do {
        try context.save()
        StationUpdatersLogger.markingSongAsPlayed.info("Marked song as played: \(song.title)")
      } catch {
        StationUpdatersLogger.markingSongAsPlayed.error("Error marking song as played: \(error)")
      }
    }
  }
}

//extension CurrentSongUpdater {
//  public func markPlayed(songWithID: PersistentIdentifier) {
//    if let song = self[songWithID, as: TopTracksSong.self] {
//      song.lastPlayed = Date()
//      do {
//        try modelContext.save()
//        StationUpdatersLogger.markingSongAsPlayed.info("Marked song as played: \(song.title)")
//      } catch {
//        StationUpdatersLogger.markingSongAsPlayed.error("Error marking song as played: \(error)")
//      }
//    }
//  }
//}

@MainActor
extension CurrentSongUpdater {
  public func remove(songWithID: PersistentIdentifier) {
    let context = CommonContainer.shared.container.mainContext
    if let song =  context.model(for: songWithID) as? TopTracksSong  {
      context.delete(song)
      do {
        try context.save()
        StationUpdatersLogger.removingSong.info("Removing song: \(song.title)")
      } catch {
        StationUpdatersLogger.removingSong.error("Error removing song: \(error)")
      }
    }
  }
}

//extension CurrentSongUpdater {
//  public func remove(songWithID: PersistentIdentifier) {
//    if let song = self[songWithID, as: TopTracksSong.self] {
//      modelContext.delete(song)
//      do {
//        try modelContext.save()
//        StationUpdatersLogger.removingSong.info("Removing song: \(song.title)")
//      } catch {
//        StationUpdatersLogger.removingSong.error("Error removing song: \(error)")
//      }
//    }
//  }
//}

@MainActor
extension CurrentSongUpdater {
  public func changeRatingFor(songWithID: PersistentIdentifier,
                              to rating: SongRating)  {
    let context = CommonContainer.shared.container.mainContext
    if let song =  context.model(for: songWithID) as? TopTracksSong {
      song.songRating = rating
      song.lastPlayed = Date()
      do {
        try context.save()
        StationUpdatersLogger.changedSongRating.info("Changed rating of \(song.title) to \(rating.name)")
      } catch {
        StationUpdatersLogger.changedSongRating.error("Error updating song rating: \(error)")
      }
    }
  }
}
