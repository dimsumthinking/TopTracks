import Model
import MusicKit
import Foundation

public class CurrentSong {
  public static let shared = CurrentSong()
  
  public internal(set) var song: Song? {
    didSet {
//      if let song {
        continuation?.yield(song)
//      }
    }
  }
  private var hasNoStreamSubscriber = true
  
  private var continuation: AsyncStream<Song?>.Continuation?
}

extension CurrentSong {
  public func currentSongStream() throws -> AsyncStream<Song?> {
    guard hasNoStreamSubscriber else {
      throw HasCurrentSongStreamSubscriber()
    }
    return AsyncStream(Song?.self) { continuation in
      self.continuation = continuation
    }
  }
}


extension CurrentSong {
  #if !os(macOS)
  public func setCurrentSong(using entry: ApplicationMusicPlayer.Queue.Entry) {
    guard let item = entry.item else {return}
    switch item {
    case .song(let song):
      self.song = song
      markSongAsPlayed()
    default:
      print("Entry is not a song")
    }
    CurrentQueue.shared.refillQueueIfNeeded()
  }
  #endif
  
  public func noSongSelected() {
    self.song = nil
  }
  
  
  public func removeCurrentSong() {
//    guard let topTracksStation = CurrentStation.shared.topTracksStation,
//          let topTracksSong else { return }
    fatalError("missing remove in top tracks station")
//    topTracksStation.remove(topTracksSong: topTracksSong)
  }
}

extension CurrentSong {
  public var artwork: Artwork? {
    if let storedArtwork = topTracksSong?.song?.artwork {
      return storedArtwork
    } else {
      return song?.artwork
    }
  }
}

extension CurrentSong {
  public var ratingIconName: String {
    topTracksSong?.songRating.icon ?? "heart"
  }
  
  public var ratingName: String {
    topTracksSong?.songRating.name ?? "It's ok"
  }
  
  public func changeRating(to rating: SongRating) {
    fatalError("Missing save is possible in TopTracksSong")
//    topTracksSong?.songRating = rating
//    topTracksSong?.station.saveIfPossible()    
  }
}

extension CurrentSong {
  private var topTracksSong: TopTracksSong? {
    guard let station = CurrentStation.shared.nowPlaying,
          let song else { return nil }
    return station.topTracksSongMatching(song)
  }
  
  private func markSongAsPlayed() {
//    if let topTracksSong {
//      topTracksSong.lastPlayed = Date()
//      topTracksSong.saveIfPossible()
//    }
    print("Missing save is possible in TopTracksSong")
  }
}

private struct HasCurrentSongStreamSubscriber: Error {}
