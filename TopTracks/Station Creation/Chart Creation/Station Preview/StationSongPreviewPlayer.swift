import AVFAudio
import MusicKit

let songPreviewPlayer = StationSongPreviewPlayer()

class StationSongPreviewPlayer {
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

extension StationSongPreviewPlayer {
  func play(_ song: Song) {
    
    if let url = song.previewAssets?.first?.url {
      Task {
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          audioPlayer = try AVAudioPlayer(data: data)
          audioPlayer?.play()
        } catch {
          print(error, "\nCan't play from url for \(song.title)")
        }
      }
    } else {
      print("Can't get url for preview for \(song.title)")
    }
  }
  
  func stop() {
    audioPlayer = nil
  }
}


//extension MusicTestPreviewPlayer {
//  func play(_ result: MusicTestResult) {
//
//    if let data = result.previewData {
//      do {
//        audioPlayer = try AVAudioPlayer(data: data)
//        audioPlayer?.play()
//      }
//      catch {
//        print(error, "\nCan't get preview data for \(result.song.title)")
//      }
//    } else {
//      if let url = result.song.previewAssets?.first?.url {
//        do {
//        audioPlayer = try AVAudioPlayer(contentsOf: url)
//        audioPlayer?.play()
//        } catch {
//          print(error, "\nCan't play from url for \(result.song.title)")
//        }
//      } else {
//        print("Can't get url for preview for \(result.song.title)")
//      }
//    }
//  }
//}
