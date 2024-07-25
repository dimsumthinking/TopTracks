import Model
import MusicKit
import Observation
import SwiftData

@MainActor
@Observable
public class CurrentSong {
  public static let shared = CurrentSong()
  public internal(set) var nowPlaying: TopTracksSong?
  private let songUpdater = CurrentSongUpdater()
}

extension CurrentSong {
  public func setCurrentSong(using entry: ApplicationMusicPlayer.Queue.Entry)  throws {
    guard let item = entry.item else {return}
    switch item {
    case .song(let song):
      nowPlaying = CurrentStation.shared.nowPlaying?.topTracksSongMatching(song)
      if let persistentModelID = nowPlaying?.persistentModelID {
        Task {
          await songUpdater.markPlayed(songWithID: persistentModelID)
        }
      }
    default:
      print("Entry is not a song")
    }
    CurrentQueue.shared.refillQueueIfNeeded()
  }
   
  
  public func noSongSelected() {
    self.nowPlaying = nil
  }
  
  public func removeCurrentSong() throws {
    if let persistentModelID = nowPlaying?.persistentModelID {
      Task {
        await songUpdater.remove(songWithID: persistentModelID)
        try await ApplicationMusicPlayer.shared.skipToNextEntry()
      }
    }
  }
}

extension CurrentSong {
  public var artwork: Artwork? {
    nowPlaying?.song?.artwork
  }
}

extension CurrentSong {
  public var ratingIconName: String {
    nowPlaying?.songRating.icon ?? "heart"
  }
  
  public var ratingName: String {
    nowPlaying?.songRating.name ?? "It's ok"
  }
  
  public var duration: Double {
    nowPlaying?.song?.duration ?? 0
  }
  
  public func changeRating(to rating: SongRating)  throws {
    if let persistentModelID = nowPlaying?.persistentModelID {
      Task {
        await songUpdater.changeRatingFor(songWithID: persistentModelID,
                                          to: rating)
      }
    }
  }
}

