//import Foundation
//import SwiftUI
import MusicKit
import AVFAudio

let previewPlayer = NewStationTrackPreviewPlayer()

class NewStationTrackPreviewPlayer {
  var audioPlayer: AVAudioPlayer?
}


extension NewStationTrackPreviewPlayer {
  func preview(_ song: Song) {
    guard let url = song.previewAssets?.first?.url else {return}
    Task {let (data, _) = try await URLSession.shared.data(from: url)
      if let player = audioPlayer {
        player.delegate?.audioPlayerDidFinishPlaying?(player, successfully: true)
      }
      audioPlayer = try? AVAudioPlayer(data: data)
      audioPlayer?.play()
    }
  }
  func stopPreviewingSong() {
    audioPlayer = nil
  }
}
