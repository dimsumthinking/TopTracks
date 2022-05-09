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
  func setCategory(of testResult: MusicTestResult,
                   to category: RotationCategory) {
    if let index = testResults.firstIndex(of: testResult) {
      self[index].rotationCategory = category
      
    }
//    testResults = testResults.map{result in
//      MusicTestResult(for: result.song,
//                      rotationCategory: result == testResult ? category : testResult.rotationcategory)}
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

extension MusicTestSongs {
  var numberOfPotentialSongs: Int {
    testResults.filter{updateCategories.contains($0.rotationCategory)}.count
  }
  //  var numberOfPotentialSongs: Int {
//    testResults.filter{standardRotationCategories.contains($0.rotationCategory)}.count
//  }
  var numberOfCategories: Int {
    numberOfPotentialSongs < 36 ? 3 : 4
  }
  var minimumNumberOfSongsPerCategory: Int {
    numberOfPotentialSongs < 27 ? numberOfPotentialSongs/3 : 9
  }
  var maximumNumberOfSongsPerCategory: Int {
    numberOfPotentialSongs < 48 ? numberOfPotentialSongs/numberOfCategories : 12
  }
  var minimumNumberOfSpiceSongs: Int {
    9
  }
  func removeMessage(for category: RotationCategory) -> String {
    let int = numberOfSongs(in: category)
    return "Tap \(int - maximumNumberOfSongsPerCategory) songs to remove from \(category.description) and move down to \(category.next)"
  }
  func removeMessageforSpice() -> String {
    let int = numberOfSongs(in: .spice)
      return "Tap up to \(int - minimumNumberOfSpiceSongs) songs you don't want to hear in this station"
  }
  func addMessage(for category: RotationCategory) -> String {
    let int = numberOfSongs(in: category)
    return "Tap \(minimumNumberOfSongsPerCategory - int) songs to move up to the \(category.description) category"
  }
  
  func displayMessage(for category: RotationCategory) -> String {
    "Your \(numberOfSongs(in: category)) \(category.description) songs"
  }
  
  func numberOfSongs(in category: RotationCategory) -> Int {
    songs(in: category).count
  }
  
  func songs(in category: RotationCategory) -> [MusicTestResult] {
    testResults.filter{$0.rotationCategory == category}
  }
  
  func songs(categories: [RotationCategory]) -> [MusicTestResult] {
     testResults
      .filter{categories.contains($0.rotationCategory)}
      .sorted{$0.rotationCategory < $1.rotationCategory}
  }
}

extension MusicTestSongs {
  var numberOfRatedSongs: Int {
    testResults
      .filter{testResult in testResult.rotationCategory != .notRated}
      .count
  }
  var numberOfSongsToBeRated:  Int {
    min(testResults.count, 40)
  }
}

