import SwiftData
import MusicKit
import Foundation

extension  TopTracksStation {
  @MainActor
  public func rotate()  throws {
    let context = CommonContainer.shared.container.mainContext
    guard let station =  context.model(for: persistentModelID) as? TopTracksStation,
      let stacks = station.stacks else {
      throw TopTracksDataError.couldNotGetStacksForStation
    }
    let dictionaryOfStacks = try dictionaryOfStacks(from: stacks)
    StationUpdatersLogger.rotatingStation.info("Here's power pre-rotation: \(station.topSongs)")
    for (category, songs) in startingStacksAndSongs(from: stacks) {
      try split(topTracksSongs: songs,
                from: category,
                dictionaryOfStacks: dictionaryOfStacks)
    }
    StationUpdatersLogger.rotatingStation.info("Here's power post-rotation: \(station.topSongs)")

    station.stationLastUpdated = Date()
    try context.save()
  }

//extension  TopTracksStation {
//  public func rotate()  throws {
//    let (station, context) = try background.station(from: self)
//    guard let stacks = station.stacks else {
//      throw TopTracksDataError.couldNotGetStacksForStation
//    }
//    let dictionaryOfStacks = try dictionaryOfStacks(from: stacks)
//    StationUpdatersLogger.rotatingStation.info("Here's power pre-rotation: \(station.topSongs)")
//    for (category, songs) in startingStacksAndSongs(from: stacks) {
//      try split(topTracksSongs: songs,
//                from: category,
//                dictionaryOfStacks: dictionaryOfStacks)
//    }
//    StationUpdatersLogger.rotatingStation.info("Here's power post-rotation: \(station.topSongs)")
//
//    station.stationLastUpdated = Date()
//    try context.save() 
//  }
  
//  private func startingStacksAndSongs(from topTrackStacks: [TopTracksStack]) -> [(RotationCategory, [TopTracksSong])] {
//    var stacksAndSongs = [(RotationCategory, [TopTracksSong])]()
//    for stack in topTrackStacks {
//      stacksAndSongs.append((stack.rotationCategory, orderedSongs(stack.songs)))
//    }
//    return stacksAndSongs
//  }
  
//  private func dictionaryOfStacks(from topTrackStacks: [TopTracksStack]) throws
//  -> [RotationCategory: TopTracksStack] {
//    var stacksFromCategories = [RotationCategory: TopTracksStack]()
//    for stack in topTrackStacks {
//      guard stationStandardCategories.contains(stack.rotationCategory) else {
//        throw TopTracksDataError.stationMissingStandardRotationCategory
//      }
//      stacksFromCategories[stack.rotationCategory] = stack
//    }
//    return stacksFromCategories
//  }
  
//  private func orderedSongs(_ topTracksSongs: [TopTracksSong]?) -> [TopTracksSong] {
//    guard let songs = topTracksSongs else { return [TopTracksSong]() }
//    return songs
//      .sorted { $0.songRating  < $1.songRating }
//      .sorted { $0.songMotion  < $1.songMotion }
//      .sorted { $0.songRating  < $1.songRating }
//  }
  
//  private func markRemainingSame(songs: [TopTracksSong]) {
//    for song in songs {
//      song.motion = SongMotion.same.name
//    }
//  }

    
  private func split(topTracksSongs: [TopTracksSong],
                     from category: RotationCategory,
                     dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    switch category {
    case .power: try splitPower(topTracksSongs: topTracksSongs,
                                dictionaryOfStacks: dictionaryOfStacks)
    case .heavy: try splitHeavy(topTracksSongs: topTracksSongs,
                                dictionaryOfStacks: dictionaryOfStacks)
    case .medium: try splitMedium(topTracksSongs: topTracksSongs,
                                  dictionaryOfStacks: dictionaryOfStacks)
    case .light: try splitLight(topTracksSongs: topTracksSongs,
                                dictionaryOfStacks: dictionaryOfStacks)
    case .gold: try splitGold(topTracksSongs: topTracksSongs,
                              dictionaryOfStacks: dictionaryOfStacks)
    default: return
    }
  }
}

//extension TopTracksStation {
//  private func changeStack(for topTracksSong: TopTracksSong,
//                           to category: RotationCategory,
//                           dictionaryOfStacks: [RotationCategory: TopTracksStack],
//                           motion: SongMotion) throws {
//    guard let stack = dictionaryOfStacks[category] else {
//      throw TopTracksDataError.stationMissingStandardRotationCategory
//    }
//    topTracksSong.stack = stack
//    topTracksSong.motion = motion.name
//  }
//}

extension TopTracksStation {
  private func splitPower(topTracksSongs: [TopTracksSong],
                          dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    var songs = topTracksSongs
    try changeStack(for: songs.removeFirst(),
                    to: .medium,
                    dictionaryOfStacks: dictionaryOfStacks,
                    motion: .downPlus)
    for _ in 1...3 {
      try changeStack(for: songs.removeFirst(),
                      to: .heavy,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .down)
    }
    markRemainingSame(songs: songs)
  }
  
  private func splitHeavy(topTracksSongs: [TopTracksSong],
                          dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try changeStack(for: songs.removeFirst(),
                      to: .light,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .downPlus)
    }
    for _ in 1...2 {
      try changeStack(for: songs.removeFirst(),
                      to: .medium,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .down)
    }
    for _ in 1...2 {
      try changeStack(for: songs.removeLast(),
                      to: .power,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .up)
    }
    markRemainingSame(songs: songs)
  }
  
  private func splitMedium(topTracksSongs: [TopTracksSong],
                           dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try changeStack(for: songs.removeFirst(),
                      to: .light,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .down)
    }
    for _ in 1...2 {
      try changeStack(for: songs.removeLast(),
                      to: .power,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .upPlus)
    }
    for _ in 1...2 {
      try changeStack(for: songs.removeLast(),
                      to: .heavy,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .up)
    }
    markRemainingSame(songs: songs)
  }
  
  private func splitLight(topTracksSongs: [TopTracksSong],
                          dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try changeStack(for: songs.removeFirst(),
                      to: .gold,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .down)
    }
    try changeStack(for: songs.removeLast(),
                    to: .heavy,
                    dictionaryOfStacks: dictionaryOfStacks,
                    motion: .upPlus)
    for _ in 1...3 {
      try changeStack(for: songs.removeLast(),
                      to: .medium,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .up)
    }
    markRemainingSame(songs: songs)
  }
  
  private func splitGold(topTracksSongs: [TopTracksSong],
                         dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try changeStack(for: songs.removeLast(),
                      to: .light,
                      dictionaryOfStacks: dictionaryOfStacks,
                      motion: .up)
    }
    markRemainingSame(songs: songs)
  }
}





