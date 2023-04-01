import Combine
import Model
import Foundation
import MusicKit


public class ApplicationState: ObservableObject {
  public static var shared = ApplicationState()
  @Published public private(set) var currentSong: Song?
  public var endTime: Date?
  private var sleepTimer: Task<Void, Error>?

}



extension ApplicationState {
  public func setSong(to song: TopTracksSong) {
    song.markPlayed()
    currentSong = song.song
  }
  
  public func setCurrentSong(using entry: ApplicationMusicPlayer.Queue.Entry) {
    guard let item = entry.item else {return}
    switch item {
    case .song(let song):
      _ = song.anyMatchingTopTracksSong
      currentSong = song
    default:
      print("Entry is not a song")
    }
    CurrentQueue.shared.refillQueueIfNeeded()
  }
  
  public func noSongSelected() {
    currentSong = nil
  }
  
  
  public func removeCurrentSong() {
  //    currentSong?.moveEveryMatchingTopTracksSong(to: .removed)
    guard let topTracksStation = CurrentStation.shared.topTracksStation,
          let currentSong else { return }
    topTracksStation.remove(song: currentSong)
  }
}




extension ApplicationState {
  public func sleepAfter(timeInterval: TimeInterval,
                         andSongPlayingThen: Bool = false) {
    endTime = Date().addingTimeInterval(timeInterval)
    sleepTimer?.cancel()
    sleepTimer = Task {
      try? await Task.sleep(for: .seconds(10)) // timeInterval
      try Task.checkCancellation()
      if andSongPlayingThen {
        await pauseAfterCurrentSong()
      } else {
        ApplicationMusicPlayer.shared.pause()
      }
      endTime = nil
    }
  }
  
  private func pauseAfterCurrentSong() async {
    if let duration = currentSong?.duration {
      try? await Task.sleep(for: .seconds(duration - ApplicationMusicPlayer.shared.playbackTime - 1))
    }
    ApplicationMusicPlayer.shared.pause()
  }
  
  public func cancelTimer() {
    endTime = nil
    sleepTimer?.cancel()
  }
}

extension ApplicationState {
  public var currentRatingIconName: String {
    currentSong?.anyMatchingTopTracksSong?.songRating.icon ?? "heart"
  }
  
  public var currentRatingName: String {
    currentSong?.anyMatchingTopTracksSong?.songRating.name ?? "It's ok"
  }
  
  public func changeRating(to rating: SongRating) {
    currentSong?.changeRatingForEveryMatchingTopTracksSong(to: rating)
  }

  
}


