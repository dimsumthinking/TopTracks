import MusicKit
import Foundation
import SwiftUI
import CoreData

class NewStationSongsInPlaylist: ObservableObject {
  @Published var songsAndRatings: [NewStationSongRating] = []
  private(set) var playlist: Playlist
  
  init(_ playlist: Playlist) {
    self.playlist = playlist
    Task {
      await self.fetchSongs()
    }
  }
}

extension NewStationSongsInPlaylist {
  @MainActor
  private func fetchSongs()  async {
    async let results = playlist.with([.tracks])
    if let tracks = try? await results.tracks {
      self.songsAndRatings
      = tracks
        .compactMap(songWithArtwork)
        .map{NewStationSongRating.init(song: $0, rating: 0)}
    }
  }
  
  private func songWithArtwork(from track: Track) -> Song? {
    guard case Track.song(let song) = track else {return nil}
    guard song.artwork != nil else {return nil}
    return song
  }
}

extension NewStationSongsInPlaylist {
  @MainActor
  func createStation(among stationNames: [String],
                     context: NSManagedObjectContext = PersistenceController.newBackgroundContext) {
    let _ = TopTracksStation(stationName: playlist.name
                                   + decorationForStationName(given: stationNames),
                                  playlist: playlist,
                                   buttonPosition: stationNames.count,
                                  songsAndRatings: songsAndRatings,
                                  context: context)
        do {
          try context.save()
          print("tried to save \(playlist.name)")
        } catch {
          print("Not able to create a new station")
        }
  }
  
  private func decorationForStationName(given stationNames: [String]) -> String {
    let numberWithSameStart = stationNames
      .filter{name in name.starts(with: playlist.name)}.count
    
    return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
  }
  
//  func addStation(to stationNames: [String],
//                  in context: NSManagedObjectContext,
//                  with playlist: Playlist) {
//
//    
//    let station = TopTracksStation(in: context,
//                             playlistID: playlist.id.rawValue,
//                             stationName: playlist.name + decorationForStationName(given: stationNames),
//                             buttonPosition: stationNames.count)
//    
//    let selectedSongs = selectedSongs()
//    let sortedSongs = stacks(from: selectedSongs)
//    
//    let power = TopTracksStack(rotationCategory: .power, in: context)
//    let current = TopTracksStack(rotationCategory: .current, in: context)
//    let added = TopTracksStack(rotationCategory: .added, in: context)
//    let spice = TopTracksStack(rotationCategory: .spice, in: context)
//    
//    station.stacks = NSSet(array: [power, current, added, spice])
//    power.station = station
//    current.station = station
//    added.station = station
//    spice.station = station
//
//    if let powerList = sortedSongs[.power] {
//      var stackSongs = [TopTracksSong]()
//      for (index, song) in powerList.enumerated() {
//        let tune = TopTracksSong(song: song, in: context, stackPosition: index)
//        tune.stack = power
//        stackSongs.append(tune)
//      }
//      power.songs = NSSet(array: stackSongs)
//    }
//    
//    if let currentList = sortedSongs[.current] {
//      var stackSongs = [TopTracksSong]()
//      for (index, song) in currentList.enumerated() {
//        let tune = TopTracksSong(song: song, in: context, stackPosition: index)
//        tune.stack = current
//        stackSongs.append(tune)
//      }
//      current.songs = NSSet(array: stackSongs)
//    }
//    
//    if let addedList = sortedSongs[.added] {
//      var stackSongs = [TopTracksSong]()
//      for (index, song) in addedList.enumerated() {
//        let tune = TopTracksSong(song: song, in: context, stackPosition: index)
//        tune.stack = added
//        stackSongs.append(tune)
//      }
//      added.songs = NSSet(array: stackSongs)
//    }
//    
//    if let spiceList = sortedSongs[.spice] {
//      var stackSongs = [TopTracksSong]()
//      for (index, song) in spiceList.enumerated() {
//        let tune = TopTracksSong(song: song, in: context, stackPosition: index)
//        tune.stack = spice
//        stackSongs.append(tune)
//      }
//      spice.songs = NSSet(array: stackSongs)
//    }
//    
//    do {
//      try context.save()
//      print("tried to save \(playlist.name)")
//    } catch {
//      print("Not able to create a new station")
//    }
//  }
//  
//
//  
//  private func selectedSongs() -> [Song] {
//     songsAndRatings
//      .filter{item in item.rating > 0}
//      .sorted{item1, item2 in item1.rating > item2.rating}
//      .map(\.song)
//  }
//  
//  
//  private func stacks(from songs: [Song]) -> [RotationCategory: [Song]]{
//    
//    if songs.count < 36 {
//      let n = Int(songs.count / 3)
//      return [RotationCategory.power: Array(songs[..<n]),
//              .current: Array(songs[n..<2*n]),
//              .added: Array(songs[(2*n)...])]
//    } else {
//      let n = min(Int(songs.count / 4), preferredMaximumSongsPerPlaylist)
//      return [RotationCategory.power: Array(songs[..<n]),
//              .current: Array(songs[n..<2*n]),
//              .added: Array(songs[2*n..<3*n]),
//              .spice: Array(songs[(3*n)...])]
//    }
//  }
}
