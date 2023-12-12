import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func add(songs songsToAdd: [Song],
                  for playlist: Playlist) throws {
    let (station, context) = try background.station(from: self)

//    let context = backgroundModelActor.context
//    guard let station = context.model(for: self.persistentModelID) as? TopTracksStation else {return}
    let added = try addedStack(for: station, in: context)
    try add(songs: songsToAdd,
            to: added,
            in: context)
    if let playlistLastModifiedDate = playlist.lastModifiedDate {
      station.playlistLastUpdated = playlistLastModifiedDate
    }
    station.playlistAsData = try? JSONEncoder().encode(playlist)
    station.stationLastUpdated = Date()
    try context.save()
  }
  
  private func addedStack(for station: TopTracksStation,
                          in context: ModelContext) throws -> TopTracksStack {
    if let addedStack = stack(for: .added),
       let addedStackInContext = context.model(for: addedStack.persistentModelID) as? TopTracksStack {
      return addedStackInContext
    } else { //TODO: watch for existing added stack
      let added = TopTracksStack(category: .added)
      context.insert(added)
      added.station = station
      station.stationLastUpdated = Date()
      StationUpdatersLogger.updatingPlaylist
        .info("Pre - Added for \(station.stationName) has \(added.orderedSongs.count)")
      return added
    }
  }
  
  private func add(songs songsToAdd: [Song],
                   to addedStack: TopTracksStack,
                   in context: ModelContext) throws {
    let ids = availableSongs.compactMap(\.songID)
    for song in songsToAdd where !ids.contains(song.id.rawValue) {
      let topTracksSong = TopTracksSong(song: song)
      context.insert(topTracksSong)
      topTracksSong.stack = addedStack
    }
    StationUpdatersLogger.updatingPlaylist
      .info("Post - Added for \(addedStack.station?.stationName ?? "") has \(addedStack.orderedSongs.count)")
  }
}

