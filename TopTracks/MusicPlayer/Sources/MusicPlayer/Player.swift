import Combine
import MusicKit

public class Player: ObservableObject {
  public static var shared = Player()
  private var player = ApplicationMusicPlayer.shared
 
  
  
  init() {
  }
  
}

extension Player {
  public func play() {
    Task {
      try await player.play()
    }
  }
  
  public func pause() {
    player.pause()
  }
  
  public func nextSong() {
    Task {
      try await player.skipToNextEntry()
    }
  }
  
  public func previousSong() {
    Task {
      try await player.skipToPreviousEntry()
    }
  }
  
  public func play(_ songs: MusicItemCollection<Song>) {
    Task {
      player.queue = ApplicationMusicPlayer.Queue(for: songs)
      try await player.prepareToPlay()
      try await player.play()
      
    }
  }
  
  public func replaceQueue(with songs: MusicItemCollection<Song>) {
    Task {
      player.queue = ApplicationMusicPlayer.Queue(for: songs)
      try await player.prepareToPlay()
      play()
    }
  }
}

extension Player {
  
  public func fetch() async throws {
    var request = MusicCatalogSearchRequest(term: "jazz", types: [Song.self])
    request.limit = 25
    let songResults = try await request.response()
    play(songResults.songs)
  }
}
import Foundation
extension Player {
  var currentSong: Song? {
    guard let currentEntryItem = ApplicationMusicPlayer.shared.queue.currentEntry?.item else { return nil }
    if case let .song(song) = currentEntryItem {
      return song
    } else {
      return nil
    }
       
  }
  
  var currentArtwork: Artwork? {
    currentSong?.artwork
  }
  var currentTitle: String {
    currentSong?.title ?? ""
  }
  var currentArtist: String {
    currentSong?.artistName ?? ""
  }
  var currentDuration: TimeInterval {
    currentSong?.duration ?? 180
  }
}
