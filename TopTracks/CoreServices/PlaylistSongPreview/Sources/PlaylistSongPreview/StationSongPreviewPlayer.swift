import AVFAudio
import MusicKit
import Constants

public let songPreviewPlayer = StationSongPreviewPlayer()

public class StationSongPreviewPlayer {
  
  private let previewPlayerDelegate = PreviewPlayerDelegate()
  
#if !os(macOS)
  var audioPlayer: AVAudioPlayer?
  
  
  init() {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.playback)
    } catch {
      print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
  }
#endif
}


extension StationSongPreviewPlayer {
  func play(_ song: Song) {
#if !os(macOS)
    
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
#endif
  }
  
  public func stop() {
#if !os(macOS)
    audioPlayer = nil
#endif
  }
}

fileprivate class PreviewPlayerDelegate:  NSObject, AVAudioPlayerDelegate {
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
#if !os(macOS)
    songPreviewPlayer.audioPlayer = nil
#endif
  }
}
