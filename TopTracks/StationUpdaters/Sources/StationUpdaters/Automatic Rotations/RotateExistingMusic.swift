import Model
import MusicKit
import SwiftData

public class RotateExistingMusic {
  let station: TopTracksStation
  var categoriesOfSongs = [RotationCategory: [TopTracksSong]]()
  
  public init(in station: TopTracksStation) {
    self.station = station
    stationStandardCategories.forEach { category in
      guard let songs = station.stack(for: category)?.songs else {return}
      categoriesOfSongs[category] = orderedSongs(Array(songs))
    }
  }
}

extension RotateExistingMusic {
  public func rotate() {
    categoriesOfSongs.forEach { category, songs in
      split(topTracksSongs: songs, from: category)
    }
    guard let context = station.context else { return }
    do {
      try context.save()
    } catch {
      print("Could not save station after rotate")
    }
  }
    
  private func split(topTracksSongs: [TopTracksSong],
                     from category: RotationCategory) {
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

extension RotateExistingMusic {
  private func splitPower(topTracksSongs: [TopTracksSong]) {
    var songs = topTracksSongs
    station.changeStack(for: songs.removeFirst(), to: .medium)
    for _ in 1...3 {
      station.changeStack(for: songs.removeFirst(), to: .heavy)
    }
    markRemainingSame(songs)
  }
  
  private func splitHeavy(topTracksSongs: [TopTracksSong]) {
    var songs = topTracksSongs
    for _ in 1...2 {
      station.changeStack(for: songs.removeFirst(), to: .light)
    }
    for _ in 1...2 {
      station.changeStack(for: songs.removeFirst(), to: .medium)
    }
    for _ in 1...2 {
      station.changeStack(for: songs.removeLast(), to: .power)
    }
    markRemainingSame(songs)
  }
  
  private func splitMedium(topTracksSongs: [TopTracksSong]) {
    var songs = topTracksSongs
    for _ in 1...2 {
      station.changeStack(for: songs.removeFirst(), to: .light)
    }
    for _ in 1...2 {
      station.changeStack(for: songs.removeLast(), to: .power)
    }
    for _ in 1...2 {
      station.changeStack(for: songs.removeLast(), to: .heavy)
    }
   markRemainingSame(songs)
  }
  
  private func splitLight(topTracksSongs: [TopTracksSong]) {
    var songs = topTracksSongs
    for _ in 1...2 {
      station.changeStack(for: songs.removeFirst(), to: .gold)
    }
    station.changeStack(for: songs.removeLast(), to: .heavy)
    for _ in 1...3 {
      station.changeStack(for: songs.removeLast(), to: .medium)
    }
    markRemainingSame(songs)
  }
  
  private func splitGold(topTracksSongs: [TopTracksSong]) {
    var songs = topTracksSongs
    for _ in 1...2 {
      station.changeStack(for: songs.removeLast(), to: .light)
    }
    markRemainingSame(songs)
  }
}



