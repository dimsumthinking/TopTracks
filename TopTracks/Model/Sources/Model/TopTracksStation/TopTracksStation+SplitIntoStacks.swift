import MusicKit
import CoreData

func splitSongsIntoCategories(songs: [Song]) -> [RotationCategory: [Song]] {
  var songsInCategories = [RotationCategory: [Song]]()
  let proposedStackSize = songs.count.isMultiple(of: 4)   ? songs.count/4 : songs.count/4 + 1
  let stackSize = min(proposedStackSize, 10)
  songsInCategories[.power] = Array(songs[...(stackSize - 1)])
  songsInCategories[.heavy] = Array(songs[stackSize...(2 * stackSize - 1)])
  songsInCategories[.medium] = Array(songs[(2 * stackSize)...(3 * stackSize - 1)])
  songsInCategories[.light] = Array(songs[(3 * stackSize)...min(4 * stackSize - 1, songs.count - 1)])
  if songs.count > 50 {
    songsInCategories[.gold] = Array(songs[(4 * stackSize)...])
  }
  return songsInCategories
}

public func stackSizes(from totalNumberOfSongs: Int) -> [(RotationCategory, Int)] {
  let proposedStackSize = totalNumberOfSongs.isMultiple(of: 4)   ? totalNumberOfSongs/4 : totalNumberOfSongs/4 + 1
  let stackSize = min(proposedStackSize, 10)
  return stationStandardCategories.map { category in
    switch category {
    case .power, .heavy, .medium:
      return (category, stackSize)
    case .light:
      return (.light, min(stackSize, totalNumberOfSongs - 3 * stackSize))
    case .gold:
      guard totalNumberOfSongs > 50 else {return (category,0)}
      return (.gold, max(0, min(40, totalNumberOfSongs - 4 * stackSize)))
    default:
      return (category, 0)
    }
    
  }
}
