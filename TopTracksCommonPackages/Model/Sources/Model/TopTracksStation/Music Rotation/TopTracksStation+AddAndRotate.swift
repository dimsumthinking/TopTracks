import SwiftData
import MusicKit
import Foundation

extension  TopTracksStation {
  public func addAndRotate()  throws {
    let (station, context) = try background.station(from: self)
    try addArchivedStackIfNeeded(station: station,
                                 context: context)
    guard let stacks = station.stacks else {
      throw TopTracksDataError.couldNotGetStacksForStation
    }
    guard let added = stacks.filter{ $0.rotationCategory == .added }.first,
     var addedSongs = added.songs?.sorted{$0.lastPlayed < $1.lastPlayed},
        addedSongs.count > 5 else {
          try rotate()
          return
        }
        
    
    let dictionaryOfStacks = try dictionaryOfStacks(from: stacks)
    for (category, songs) in startingStacksAndSongs(from: stacks) where stationStandardCategories.contains(category) {
      guard let songToDemote = songs.first else {return}
      StationUpdatersLogger.addingSongsToStation.info("Replacing \(songToDemote.title) from \(category.name) with \(addedSongs.first?.title ?? "")")
      try demote(topTracksSong: songToDemote,
                 dictionaryOfStacks: dictionaryOfStacks)
      try changeStack(for: addedSongs.removeFirst(),
                  to: category,
                  dictionaryOfStacks: dictionaryOfStacks,
                  motion: .up)
      
    }
    station.stationLastUpdated = Date()
    try context.save()
    try rotate()
  }
}

