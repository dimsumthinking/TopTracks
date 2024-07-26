import SwiftData
import MusicKit
import Foundation


extension TopTracksStation {
  @MainActor
  public func updateWith(songs songsToAdd: [Song],
                         for playlist: Playlist) throws {
    let context = CommonContainer.shared.container.mainContext
    guard let station =  context.model(for: persistentModelID) as? TopTracksStation else {
      throw TopTracksDataError.stationMissingAddedCategory
    }
    let categorizedSongs = categorized(songs: songsToAdd)
    
    let remainingSongs = try moveOrDeleteCurrentSongs(station: station,
                                                      basedOn: categorizedSongs,
                                                      context: context)
    try addRemainingSongs(to: station,
                          from: remainingSongs,
                          context: context)
    if let playlistLastModifiedDate = playlist.lastModifiedDate {
      station.playlistLastUpdated = playlistLastModifiedDate
    }
    station.playlistAsData = try? JSONEncoder().encode(playlist)
    station.stationLastUpdated = Date()
    try context.save()
  }

//extension TopTracksStation {
//  public func updateWith(songs songsToAdd: [Song],
//                         for playlist: Playlist) throws {
//    let (station, context) = try background.station(from: self)
//    let categorizedSongs = categorized(songs: songsToAdd)
//    
//    let remainingSongs = try moveOrDeleteCurrentSongs(station: station,
//                                                      basedOn: categorizedSongs,
//                                                      context: context)
//    try addRemainingSongs(to: station,
//                          from: remainingSongs,
//                          context: context)
//    if let playlistLastModifiedDate = playlist.lastModifiedDate {
//      station.playlistLastUpdated = playlistLastModifiedDate
//    }
//    station.playlistAsData = try? JSONEncoder().encode(playlist)
//    station.stationLastUpdated = Date()
//    try context.save()
//  }
  
  
  
  private func moveOrDeleteCurrentSongs(station: TopTracksStation,
                                        basedOn categorizedSongs: [Song: RotationCategory],
                                        context: ModelContext) throws -> [Song: RotationCategory] {
    var moved = 0
    var deleted = 0
    var categorizedSongs = categorizedSongs
    for topTracksSong in station.activeSongs {
      if let song = topTracksSong.song,
         let category = categorizedSongs[song],
         let stack = station.stack(for: category) {
        topTracksSong.stack = stack
        categorizedSongs.removeValue(forKey: song)
        moved += 1
      } else {
        context.delete(topTracksSong)
        deleted += 1
      }
    }
    StationUpdatersLogger.updatingChart.info("Updating \(station.stationName). Moved \(moved.description), Deleted \(deleted.description)")
    return categorizedSongs
    
  }
  
  private func addRemainingSongs(to station: TopTracksStation,
                                 from remainingSongs: [Song: RotationCategory],
                                 context: ModelContext) throws {
    var added = 0
    for song in remainingSongs.keys {
      if let category = remainingSongs[song],
         let stack = station.stack(for: category) {
        let topTracksSong = TopTracksSong(song: song)
        topTracksSong.stack = stack
        context.insert(topTracksSong)
        added += 1
      }
    }
    StationUpdatersLogger.updatingChart.info("Updating \(station.stationName). Added \(added.description)")
  }
}

extension TopTracksStation {
  private func categorized(songs:  [Song]) -> [Song: RotationCategory] {
    var songsWithCategory = [Song: RotationCategory]()
    let _ = splitSongsIntoCategories(songs: songs)
      .map { category, songs in
        for song in songs {
          songsWithCategory[song] = category
        }
        return category
      }
    return songsWithCategory
  }
}
