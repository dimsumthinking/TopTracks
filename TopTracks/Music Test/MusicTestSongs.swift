@preconcurrency import MusicKit
import Foundation
import SwiftUI
import CoreData


class MusicTestSongs: ObservableObject {
  @Published var testResults: [MusicTestResult] = []
  private(set) var playlist: Playlist
  
  init(_ playlist: Playlist) {
    self.playlist = playlist
    Task {
      await self.fetchSongs(playlist: playlist)
    }
  }
  subscript(index: Int) -> MusicTestResult {
    get {
      testResults[index]
    }
    set {
      testResults[index] = newValue
    }
  }
  var count: Int {
    testResults.count
  }
}

extension MusicTestSongs {
  @MainActor
  private func fetchSongs(playlist: Playlist)  async {
    async let results = playlist.with([.tracks])
    if let tracks = try? await results.tracks {
      self.testResults
      = tracks
        .compactMap(songWithArtwork)
        .map{MusicTestResult.init(for: $0)}
    }
  }
  
  private func songWithArtwork(from track: Track) -> Song? {
    guard case Track.song(let song) = track else {return nil}
    guard song.artwork != nil else {return nil}
    return song
  }
}

//extension MusicTestSongs {
//  @MainActor
//  func createStation(among stationNames: [String],
//                     context: NSManagedObjectContext = PersistenceController.newBackgroundContext) {
//    let _ = TopTracksStation(stationName: playlist.name
//                                   + decorationForStationName(given: stationNames),
//                                  playlist: playlist,
//                                   buttonPosition: stationNames.count,
//                                  songsAndRatings: songsAndRatings,
//                                  context: context)
//        do {
//          try context.save()
//          print("tried to save \(playlist.name)")
//        } catch {
//          print("Not able to create a new station\n", error)
//        }
//  }
//
//  private func decorationForStationName(given stationNames: [String]) -> String {
//    let numberWithSameStart = stationNames
//      .filter{name in name.starts(with: playlist.name)}.count
//
//    return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
//  }
//}

//extension MusicTestSongs {
//  func assignCategories(for numberRated: Int, outOf maximum: Int) {
//    let upper = min(numberRated, maximum)
//    let n = upper / 3
//    let firstLimit = n + min(1, upper % 3)
//    let secondLimit = 2 * n + upper % 3
//    let sortedSongs = songsAndRatings.sorted{$0.rating > $1.rating}
//    for index in sortedSongs.indices {
//      switch index {
//      case  0 ..< firstLimit:
//        assign(.power, to: sortedSongs[index])
//      case firstLimit..<secondLimit:
//        assign(.current, to: sortedSongs[index])
//      case secondLimit..<min(numberRated, maximum):
//        assign(.added, to: sortedSongs[index])
//      default:
//        assign(sortedSongs[index].rating < 1 ? .notIncluded : .spice,
//               to: sortedSongs[index])
//      }
//    }
//  }
//
//  private func assign(_ rotationCategory: RotationCategory,
//                      to song: NewStationSongRating) {
//    let index = songsAndRatings.firstIndex(of: song) ?? 0
//    songsAndRatings[index].rotationCategory = rotationCategory
//  }
//}
