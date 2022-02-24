import AVFAudio

//let previewPlayer = NewStationTrackPreviewPlayer()

class NewStationTrackPreviewPlayer {
  var audioPlayer: AVAudioPlayer?
  
  init() {
    let audioSession = AVAudioSession.sharedInstance()
         do {
            try audioSession.setCategory(.playback)
         } catch {
             print("Setting category to AVAudioSessionCategoryPlayback failed.")
         }
  }
}
