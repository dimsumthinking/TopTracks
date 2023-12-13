import Model
import MusicKit
import Foundation
import SwiftData
import Observation

@Observable
public class CurrentSong {
  public static let shared = CurrentSong()
  public internal(set) var song: Song?
}

extension CurrentSong {
  public func setCurrentSong(using entry: ApplicationMusicPlayer.Queue.Entry)  throws {
    guard let item = entry.item else {return}
    switch item {
    case .song(let song):
      self.song = song
      if let station = CurrentStation.shared.nowPlaying {
        try station.markPlayed(for: song)
      }
    default:
      print("Entry is not a song")
    }
    CurrentQueue.shared.refillQueueIfNeeded()
  }
  
  public func noSongSelected() {
    self.song = nil
  }
  public func removeCurrentSong() throws {
    if let ttSong = topTracksSong {
      try ttSong.remove()
    }
  }
  
//  public func removeCurrentSong() {
//    guard let topTracksSong,
//    let context = topTracksSong.context else { return }
//    do {
//      context.delete(topTracksSong)
//      try context.save()
//      Task {
//        try await ApplicationMusicPlayer.shared.skipToNextEntry()
//      }
//    } catch {
//      print("Unable to remove current song")
//    }
//  }
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
  
  public func changeRating(to rating: SongRating)  throws {
    if let ttSong = topTracksSong {
      try ttSong.changeRating(to: rating)
    }
  }
  
//  public func changeRating(to rating: SongRating) {
//    guard let topTracksSong,
//          let context = topTracksSong.context else {return}
//    topTracksSong.songRating = rating
//    do {
//      try context.save()
//    } catch {
//      print("Unable to save rating")
//    }
//  }
}

extension CurrentSong {
  private var topTracksSong: TopTracksSong? {
    guard let station = CurrentStation.shared.nowPlaying,
          let song else { return nil }
    return station.topTracksSongMatching(song)
  }
}
