import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  func startingStacksAndSongs(from topTrackStacks: [TopTracksStack]) -> [(RotationCategory, [TopTracksSong])] {
    var stacksAndSongs = [(RotationCategory, [TopTracksSong])]()
    for stack in topTrackStacks {
      stacksAndSongs.append((stack.rotationCategory, orderedSongs(stack.songs)))
    }
    return stacksAndSongs
  }
  
  private func checkStandardStacksContained(in topTrackStacks: [TopTracksStack]) throws {
    let topTrackStacksCategories = topTrackStacks.map(\.rotationCategory)
    for category in stationStandardCategories {
      guard topTrackStacksCategories.contains(category) else {
        throw TopTracksDataError.stationMissingStandardRotationCategory
      }
    }
  }
  
  func dictionaryOfStacks(from topTrackStacks: [TopTracksStack]) throws
  -> [RotationCategory: TopTracksStack] {
    var stacksFromCategories = [RotationCategory: TopTracksStack]()
    try checkStandardStacksContained(in: topTrackStacks)
    for stack in topTrackStacks {
      stacksFromCategories[stack.rotationCategory] = stack
    }
    return stacksFromCategories
  }
  
  private func orderedSongs(_ topTracksSongs: [TopTracksSong]?) -> [TopTracksSong] {
    guard let songs = topTracksSongs else { return [TopTracksSong]() }
    return songs
      .sorted { $0.songRating  < $1.songRating }
      .sorted { $0.songMotion  < $1.songMotion }
      .sorted { $0.songRating  < $1.songRating }
  }
  
  func markRemainingSame(songs: [TopTracksSong]) {
    for song in songs {
      song.motion = SongMotion.same.name
    }
  }

  func changeStack(for topTracksSong: TopTracksSong,
                           to category: RotationCategory,
                           dictionaryOfStacks: [RotationCategory: TopTracksStack],
                           motion: SongMotion) throws {
    guard let stack = dictionaryOfStacks[category] else {
      throw TopTracksDataError.stationMissingStandardRotationCategory
    }
    topTracksSong.stack = stack
    topTracksSong.motion = motion.name
  }
  
  func demote(topTracksSong: TopTracksSong,
              dictionaryOfStacks: [RotationCategory: TopTracksStack]) throws {
    
    guard let gold = dictionaryOfStacks[.gold],
          let goldCount = gold.songs?.count,
          let archived = dictionaryOfStacks[.archived] else {
      throw TopTracksDataError.stationMissingGoldOrArchived
    }
    let targetStack = goldCount < 60 ? gold : archived
    topTracksSong.stack = targetStack
    topTracksSong.motion = SongMotion.down.name
  }
}

extension TopTracksStation {
  func checkForAddedCategoryWithAtLeast8Songs(in stacks: [TopTracksStack]) throws {
    guard let added = stacks.filter({ $0.rotationCategory == .added }).first,
    let addedSongs = added.songs?.sorted(by: {$0.lastPlayed < $1.lastPlayed}),
      addedSongs.count > 8 else {
        try rotate()
        return
      }
  }
  
  func addArchivedStackIfNeeded(station: TopTracksStation,
                               context: ModelContext) throws {
    guard let stacks = station.stacks,
          stacks.filter({$0.rotationCategory == .archived}).isEmpty else {return}
    let archived = TopTracksStack(category: .archived)
    context.insert(archived)
    archived.station = station
    try context.save()
  }
}
