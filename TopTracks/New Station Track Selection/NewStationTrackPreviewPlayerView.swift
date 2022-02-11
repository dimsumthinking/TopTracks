import SwiftUI
import MusicKit
import AVFAudio
import Foundation

struct NewStationTrackPreviewPlayerView {
  let song: Song
  @Binding var isPlaying: Bool
  @State private var delegate: NewStationTrackPreviewPlayerViewDelegate?
}

extension NewStationTrackPreviewPlayerView: View {
  var body: some View {
    ZStack {
      NewStationSongArtworkView(for: song.artwork)
      Button(action: toggleIsPlaying){
        Image(systemName: isPlaying ? "stop" : "play" )
          .font(.largeTitle)
          .foregroundColor(song.artwork?.secondaryTextColor.map(Color.init(cgColor:)) ?? .primary)
          .background(song.artwork?.backgroundColor.map(Color.init(cgColor:)) ?? .secondary)
          .buttonStyle(.bordered)
      }
    }
  }
}

extension NewStationTrackPreviewPlayerView {
  func toggleIsPlaying() {
    isPlaying.toggle()
    if isPlaying {
      previewSong()
    } else {
      stopPreviewingSong()
    }
  }
  func previewSong() {
    guard let url = song.previewAssets?.first?.url else {return}
    Task {
      async let (data, _) = try URLSession.shared.data(from: url)
      if let player = previewPlayer.audioPlayer {
        player.delegate?.audioPlayerDidFinishPlaying?(player, successfully: true)
      }
      delegate = NewStationTrackPreviewPlayerViewDelegate(self)
      do {
        previewPlayer.audioPlayer = try AVAudioPlayer(data: await data)
        previewPlayer.audioPlayer?.delegate = delegate
        previewPlayer.audioPlayer?.play()
      } catch {
        print("Couldn't create the audio player for", song.title, "by", song.artistName, error)
      }
    }
  }
  
  
  func stopPreviewingSong() {
    previewPlayer.audioPlayer = nil
  }
  func stopPlaying() {
    isPlaying = false
    stopPreviewingSong()
  }
  
  class NewStationTrackPreviewPlayerViewDelegate: NSObject, AVAudioPlayerDelegate {
    let preview: NewStationTrackPreviewPlayerView
    
    init(_ preview: NewStationTrackPreviewPlayerView) {
      self.preview = preview
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      preview.isPlaying = false
      previewPlayer.audioPlayer = nil
    }
  }
}

