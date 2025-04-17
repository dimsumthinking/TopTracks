import AVFAudio
import MusicKit
import Constants

@MainActor
public let songPreviewPlayer = StationSongPreviewPlayer()

@MainActor
public class StationSongPreviewPlayer {
  
  private let previewPlayerDelegate = PreviewPlayerDelegate()
    var audioPlayer: AVAudioPlayer?
  
  init() {
#if !os(macOS)
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.playback)
    } catch {
      print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
#endif

  }
}


extension StationSongPreviewPlayer {
  func play(_ song: Song) {
    if let url = song.previewAssets?.first?.url {
      NotificationCenter.default.post(name: Constants.previewPlayerBeginsNotification,
                                      object: nil)
      Task {
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          audioPlayer = try AVAudioPlayer(data: data)
          audioPlayer?.delegate = previewPlayerDelegate
          audioPlayer?.play()
        } catch {
          print(error, "\nCan't play from url for \(song.title)")
        }
      }
    } else {
      print("Can't get url for preview for \(song.title)")
    }
  }
  
  public func stop() {
    audioPlayer = nil
  }
  
  public var isNotPreviewing: Bool {
    return audioPlayer == nil
  }
}

fileprivate class PreviewPlayerDelegate:  NSObject, AVAudioPlayerDelegate {
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    Task { @MainActor in
      songPreviewPlayer.audioPlayer = nil
      NotificationCenter.default.post(name: Constants.previewPlayerEndsNotification,
                                      object: nil)
    }
  }
}
