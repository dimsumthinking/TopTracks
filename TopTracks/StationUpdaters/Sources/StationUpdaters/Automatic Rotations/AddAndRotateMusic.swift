import Model
import MusicKit

public class AddAndRotateMusic {
  let station: TopTracksStation
  var categoriesOfSongs = [RotationCategory: [TopTracksSong]]()
  private let hasEight: Bool
  
  public init(in station: TopTracksStation) {
    self.station = station
    hasEight = (station.stack(for: .added)?.songs?.count ?? 0) >= 8
    stationStandardCategories.forEach { category in
      guard let songs = station.stack(for: category)?.songs else {return}
      categoriesOfSongs[category] = orderedSongs(Array(songs))
    }
  }
}

extension AddAndRotateMusic {
  public func add()  throws {
    guard var added = station.stack(for: .added)?.songs else { return }
    try stationEssentialCategories.forEach { category in  // add one to each
      try station.changeStack(for: added.removeFirst(), to: category)
    }
    if hasEight {
      for _ in 1...2 {
        try station.changeStack(for: added.removeFirst(), to: .power)
      }
      try station.changeStack(for: added.removeFirst(), to: .heavy)
      try station.changeStack(for: added.removeFirst(), to: .medium)
      
      try categoriesOfSongs.forEach { category, songs in
        try addAndMove(topTracksSongs: songs, for: category)
      }

    }
    throw TTImplementationError.notImplementedYet
//    do {
//      try station.context?.save()
//    }
//    catch {
//      print("Couldn't save after adding")
//    }
//    guard station.activeSongs.count > 24 else {return}
//    let rotator = RotateExistingMusic(in: station)
//    try rotator.rotate()
  }
    
  private func addAndMove(topTracksSongs: [TopTracksSong],
                          for category: RotationCategory) throws {
    switch category {
    case .power: try splitPower(topTracksSongs: topTracksSongs)
    case .heavy: try splitHeavy(topTracksSongs: topTracksSongs)
    case .medium: try splitMedium(topTracksSongs: topTracksSongs)
    case .light: try splitLight(topTracksSongs: topTracksSongs)
    case .gold: try splitGold(topTracksSongs: topTracksSongs)
    default: return
    }
  }
}

extension AddAndRotateMusic {
  private func splitPower(topTracksSongs: [TopTracksSong]) throws {
    var songs = topTracksSongs

    try station.changeStack(for: songs.removeFirst(), to: .medium)
    for _ in 1...2 {
      try station.changeStack(for: songs.removeFirst(), to: .heavy)
    }
  }
  
  private func splitHeavy(topTracksSongs: [TopTracksSong]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try station.changeStack(for: songs.removeFirst(), to: .medium)
    }
    try station.changeStack(for: songs.removeFirst(), to: .light)
    try station.changeStack(for: songs.removeFirst(), to: .gold)
  }
  
  private func splitMedium(topTracksSongs: [TopTracksSong]) throws {
    var songs = topTracksSongs
    for _ in 1...2 {
      try station.changeStack(for: songs.removeFirst(), to: .light)
    }
    for _ in 1...3 {
      try station.changeStack(for: songs.removeFirst(), to: .gold)
    }
  }
  
  private func splitLight(topTracksSongs: [TopTracksSong]) throws {
    var songs = topTracksSongs
    for _ in 1...4 {
      try station.changeStack(for: songs.removeFirst(), to: .gold)
    }
  }
  
  private func splitGold(topTracksSongs: [TopTracksSong]) throws {
    var songs = topTracksSongs
    if songs.count > 60 {
      let excess = songs.count - 60
      for _ in 1...excess {
        try station.changeStack(for: songs.removeFirst(), to: .archived)
      }
    }
    
  }
}




