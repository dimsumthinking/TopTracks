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
  public func add() {
    guard let added = station.stack(for: .added)?.songs else { return }
    stationEssentialCategories.forEach { category in  // add one to each
      fatalError("ChangeStack is missing \(added)")
      //station.changeStack(for: added.removeFirst(), to: category)
    }
    if hasEight {
      for _ in 1...2 {
        fatalError("ChangeStack is missing")
//        station.changeStack(for: added.removeFirst(), to: .power)
      }
//      station.changeStack(for: added.removeFirst(), to: .heavy)
//      station.changeStack(for: added.removeFirst(), to: .medium)
      
      categoriesOfSongs.forEach { category, songs in
        addAndMove(topTracksSongs: songs, for: category)
      }
      fatalError("ChangeStack is missing")

    }
//    station.saveIfPossible()
    guard station.activeSongs.count > 24 else {return}
    let rotator = RotateExistingMusic(in: station)
    rotator.rotate()
    fatalError("SaveIfPossible is missing")

  }
    
  private func addAndMove(topTracksSongs: [TopTracksSong],
                          for category: RotationCategory) {
    switch category {
    case .power: splitPower(topTracksSongs: topTracksSongs)
    case .heavy: splitHeavy(topTracksSongs: topTracksSongs)
    case .medium: splitMedium(topTracksSongs: topTracksSongs)
    case .light: splitLight(topTracksSongs: topTracksSongs)
    case .gold: splitGold(topTracksSongs: topTracksSongs)
    default: return
    }
  }
}

extension AddAndRotateMusic {
  private func splitPower(topTracksSongs: [TopTracksSong]) {
    let songs = topTracksSongs
    fatalError("ChangeStack is missing \(songs)")

//    station.changeStack(for: songs.removeFirst(), to: .medium)
//    for _ in 1...2 {
////      station.changeStack(for: songs.removeFirst(), to: .heavy)
//      fatalError("ChangeStack is missing")
//
//    }
  }
  
  private func splitHeavy(topTracksSongs: [TopTracksSong]) {
    let songs = topTracksSongs
    for _ in 1...2 {
      fatalError("ChangeStack is missing \(songs)")

//      station.changeStack(for: songs.removeFirst(), to: .medium)
    }
//    station.changeStack(for: songs.removeFirst(), to: .light)
//    station.changeStack(for: songs.removeFirst(), to: .gold)
    fatalError("ChangeStack is missing")

  }
  
  private func splitMedium(topTracksSongs: [TopTracksSong]) {
    let songs = topTracksSongs
    for _ in 1...2 {
      fatalError("ChangeStack is missing \(songs)")

//      station.changeStack(for: songs.removeFirst(), to: .light)
    }
    for _ in 1...3 {
      fatalError("ChangeStack is missing")

//      station.changeStack(for: songs.removeFirst(), to: .gold)
    }
  }
  
  private func splitLight(topTracksSongs: [TopTracksSong]) {
    let songs = topTracksSongs
    for _ in 1...4 {
      fatalError("ChangeStack is missing \(songs)")

//      station.changeStack(for: songs.removeFirst(), to: .gold)
    }
  }
  
  private func splitGold(topTracksSongs: [TopTracksSong]) {
    let songs = topTracksSongs
    if songs.count > 60 {
      let excess = songs.count - 60
      for _ in 1...excess {
        fatalError("ChangeStack is missing")

//        station.changeStack(for: songs.removeFirst(), to: .archived)
      }
    }
    
  }
}




