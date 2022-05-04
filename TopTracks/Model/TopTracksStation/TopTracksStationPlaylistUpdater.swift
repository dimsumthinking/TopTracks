import MusicKit
import CoreData

extension TopTracksStation {
  var playlistCanBeUpdated: Bool {
//    return ((numberOfUnratedSongs + numberOfArchivedSongs >= 10) || numberOfSongsToMove > 10)
//    && (Date().timeIntervalSince(lastUpdatedOrNow) > 24 * 60 * 60 )
//    Date().timeIntervalSince(lastUpdatedOrNow) > 24 //TODO: change condition back * 60 * 60
  return true
  }
  
  private var numberOfUnratedSongs: Int {
    guard let unratedStack = stack(.notRated) else {return 0}
    return unratedStack.songs.count
  }
  
  private var numberOfArchivedSongs: Int {
    guard let archivedStack = stack(.archived) else {return 0}
    return archivedStack.songs.count
  }
  
  private var numberOfSpiceSongs: Int {
    guard let archivedStack = stack(.spice) else {return 0}
    return archivedStack.songs.count
  }
  
  private var numberOfSurplusSpiceSongs: Int {
    max(numberOfSpiceSongs - 10, 0)
  }
  
  private var numberOfSongs: Int {
    standardRotationCategories.compactMap{stack($0)}.map(\.songs.count).reduce(0, +)
  }
  private var numberOfAtLeastMediumRotationSongs: Int {
    basicCategories.compactMap{stack($0)}.map(\.songs.count).reduce(0, +)
  }
  
  private var numberOfSongsToMove: Int {
    guard let powerStack = stack(.power),
          let currentStack = stack(.current),
          let addedStack = stack(.added),
          let spiceStack = stack(.spice) else {return 0}
   return powerStack.songs.filter{$0.upOrDown < 0}.count +
    currentStack.songs.filter{$0.upOrDown != 0}.count +
    addedStack.songs.filter{$0.upOrDown != 0}.count +
    spiceStack.songs.filter{$0.upOrDown != 0}.count

  }
}

extension TopTracksStation {
  func updatePlaylistStation() {
    switch topTracksStationSize {
    case .full:
      if numberOfUnratedSongs + numberOfArchivedSongs >= 10 {
        update()
      } else {
        rearrange()
      }
    default:
      rearrangeMini()
    }
    if let playlistInfo = playlistInfo {
    playlistInfo.lastUpdated = Date()
    try? managedObjectContext?.save()
    }
  }

  
  private func orderedSongs(for category: RotationCategory) -> [TopTracksSong] {
    if let stack = stack(category) {
      let songs = stack.songs.sorted{$0.upOrDown > $1.upOrDown}
      songs.forEach{$0.upOrDown = 0}
      return stack.songs.sorted{$0.upOrDown > $1.upOrDown}
    } else {
      return TopTracksStack(rotationCategory: category,
                                          songs: [Song](),
                                          station: self,
                                       context: managedObjectContext ?? sharedViewContext).songs.map{$0}
    }
  }
  
  private func replaceSongs(in category: RotationCategory, with songs: [TopTracksSong]) {
    guard let stack = stack(category) else {return}
    stack.songs = Set(songs)
    try? managedObjectContext?.save()
  }
}


extension TopTracksStation {
  private func rearrange() {
    let fromA = splitA(songs: orderedSongs(for: .power))
    let fromB = splitB(songs: orderedSongs(for: .current))
    let fromC = splitC(songs: orderedSongs(for: .added))
    let fromD = splitD(songs:orderedSongs(for: .spice))
    
    replaceSongs(in: .power, with: fromA.toA + fromB.toA + fromC.toA + fromB.toArchived2a + fromC.toArchived2a)
    replaceSongs(in: .current, with: fromA.toB + fromB.toB + fromC.toB + fromC.toArchived1b + fromD.toArchived2b)
    replaceSongs(in: .added, with: fromA.toC + fromB.toC + fromC.toC + fromD.toC + fromD.toArchived2c)
    replaceSongs(in: .spice, with: fromA.toD + fromB.toD + fromC.toD + fromD.toD + fromD.toArchived1d)
  }
}

extension TopTracksStation {
  private func update() {
    let fromA = splitA(songs: orderedSongs(for: .power))
    let fromB = splitB(songs: orderedSongs(for: .current))
    let fromC = splitC(songs: orderedSongs(for: .added))
    let fromD = splitD(songs:orderedSongs(for: .spice))
    let added = toInsert(archived: orderedSongs(for: .archived), notRated: orderedSongs(for: .notRated))
    
    replaceSongs(in: .power, with: fromA.toA + fromB.toA + fromC.toA + added.toA)
    replaceSongs(in: .current, with: fromA.toB + fromB.toB + fromC.toB + added.toB)
    replaceSongs(in: .added, with: fromA.toC + fromB.toC + fromC.toC + fromD.toC + added.toC)
    replaceSongs(in: .spice, with: fromA.toD + fromB.toD + fromC.toD + fromD.toD + added.toD)
    replaceSongs(in: .notRated, with: added.toNotRated)
    replaceSongs(in: .archived, with: fromB.toArchived2a + fromC.toArchived2a + fromC.toArchived1b + fromD.toArchived1d + fromD.toArchived2b + fromD.toArchived2c + added.toArchived)
  }
}
extension TopTracksStation {
  private func splitA(songs: [TopTracksSong]) -> (toA: [TopTracksSong],
                                                  toB: [TopTracksSong],
                                                  toC: [TopTracksSong],
                                                  toD: [TopTracksSong]) {
    let toA = songs[0...1].map{$0}
    let toB =  songs[2...4].map{$0}
    let toC = songs[5...7].map{$0}
    let toD = songs[8...].map{$0}
    return(toA: toA, toB: toB, toC: toC, toD: toD)
  }
  private func splitB(songs: [TopTracksSong]) -> (toA: [TopTracksSong],
                                                  toB: [TopTracksSong],
                                                  toC: [TopTracksSong],
                                                  toD: [TopTracksSong],
                                                  toArchived2a: [TopTracksSong]) {
    let toA = songs[0...1].map{$0}
    let toB =  songs[2...3].map{$0}
    let toC = songs[4...5].map{$0}
    let toD = songs[6...7].map{$0}
    let toArchived2a = songs[8...].map{$0}
    return(toA: toA, toB: toB, toC: toC, toD: toD, toArchived2a: toArchived2a)
  }
  private func splitC(songs: [TopTracksSong]) -> (toA: [TopTracksSong],
                                                  toB: [TopTracksSong],
                                                  toC: [TopTracksSong],
                                                  toD: [TopTracksSong],
                                                  toArchived2a: [TopTracksSong],
                                                  toArchived1b: [TopTracksSong]) {
    let toA = songs[0...1].map{$0}
    let toB =  songs[2...3].map{$0}
    let toC = songs[4...5].map{$0}
    let toD = songs[6...6].map{$0}
    let toArchived2a = songs[7...8].map{$0}
    let toArchived1b = songs[9...].map{$0}
    return(toA: toA, toB: toB, toC: toC, toD: toD, toArchived2a: toArchived2a, toArchived1b: toArchived1b)
  }
  private func splitD(songs: [TopTracksSong]) -> (toC: [TopTracksSong],
                                                  toD: [TopTracksSong],
                                                  toArchived2b: [TopTracksSong],
                                                  toArchived2c: [TopTracksSong],
                                                  toArchived1d: [TopTracksSong]) {
    let toC = songs[0...0].map{$0}
    let toD = songs[1...4].map{$0}
    let toArchived2b = songs[5...6].map{$0}
    let toArchived2c = songs[7...8].map{$0}
    let toArchived1d = songs[9...].map{$0}
    return(toC: toC, toD: toD, toArchived2b: toArchived2b, toArchived2c: toArchived2c, toArchived1d: toArchived1d)
  }
  
  private func toInsert(archived: [TopTracksSong], notRated: [TopTracksSong] ) -> (toA: [TopTracksSong],
                                                                                  toB: [TopTracksSong],
                                                                                  toC: [TopTracksSong],
                                                                                  toD: [TopTracksSong],
                                                                                  toNotRated: [TopTracksSong],
                                                                                  toArchived: [TopTracksSong]) {
    let numberOfNotRated = min(notRated.count, 10)
    var songs = notRated[0..<numberOfNotRated].map{$0}
    var toArchived: [TopTracksSong]
    var toNotRated: [TopTracksSong]
    if numberOfNotRated < 10  {
      songs.append(contentsOf: archived[..<(10 - numberOfNotRated)])
      toNotRated = notRated[numberOfNotRated...].map{$0}
      toArchived = archived[(10 - numberOfNotRated)...].map{$0}
    } else {
      toArchived = archived
      toNotRated = notRated[10...].map{$0}
    }
    let toA = songs[0...3].map{$0}
    let toB =  songs[4...6].map{$0}
    let toC = songs[7...8].map{$0}
    let toD = songs[9...9].map{$0}
    return(toA: toA, toB: toB, toC: toC, toD: toD, toNotRated: toNotRated, toArchived: toArchived)
  }
}

extension TopTracksStation {
  private func rearrangeMini() {
    let songs = updateCategories.flatMap{orderedSongs(for:$0)}.shuffled()
    let count = min(songs.count/4, 10)
    replaceSongs(in: .power, with: songs[..<count].map{$0})
    replaceSongs(in: .current, with: songs[count..<(2*count)].map{$0})
    replaceSongs(in: .added, with: songs[(2*count)..<(3*count)].map{$0})
    replaceSongs(in: .spice, with: songs[(3*count)..<(4*count)].map{$0})
    replaceSongs(in: .notRated, with: songs[(4*count)...].map{$0})
    
  }
}
