import Foundation
import SwiftUI
import MusicKit
import AVFAudio

struct AppleMusicPlaylistSongPreviewView {
  let song: Song
  @State  var isPlaying = false
  static var audioPlayer: AVAudioPlayer?
  @State var delegate: AppleMusicPlaylistSongPreviewViewDelegate?
}

extension AppleMusicPlaylistSongPreviewView: View {
  var body: some View {
    HStack(alignment: .center) {
      ZStack {
        song.playlistImage
          .border(Color.primary.opacity(0.3))
          .padding()
        Button(action: toggleIsPlaying){
          Image(systemName: isPlaying ? "stop" : "play" )
            .font(.largeTitle)
            .foregroundColor(song.secondaryColor)
            .background(song.backgroundColor.opacity(0.3))
            .buttonStyle(.bordered)
        }
      }
      VStack(alignment: .leading) {
        Text(song.title)
          .padding(.bottom)
        Text(song.artistName)
          .foregroundColor(Color.secondary)
      }
      Spacer()
    }
  }
}

extension AppleMusicPlaylistSongPreviewView {
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
    Task {let (data, _) = try await URLSession.shared.data(from: url)
      if let player = AppleMusicPlaylistSongPreviewView.audioPlayer {
      player.delegate?.audioPlayerDidFinishPlaying?(player, successfully: true)
      }
      AppleMusicPlaylistSongPreviewView.audioPlayer = try? AVAudioPlayer(data: data)
      delegate = AppleMusicPlaylistSongPreviewViewDelegate(self)
      AppleMusicPlaylistSongPreviewView.audioPlayer?.delegate = delegate
      AppleMusicPlaylistSongPreviewView.audioPlayer?.play()
  }
  }
  func stopPreviewingSong() {
    AppleMusicPlaylistSongPreviewView.audioPlayer = nil
  }
  func stopPlaying() {
    isPlaying = false
    stopPreviewingSong()
  }
  
  class AppleMusicPlaylistSongPreviewViewDelegate: NSObject, AVAudioPlayerDelegate {
    let preview: AppleMusicPlaylistSongPreviewView
    
    init(_ preview: AppleMusicPlaylistSongPreviewView) {
      self.preview = preview
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      preview.isPlaying = false
    }
  }
}



extension Song: AppleMusicArtworkDisplayable {}

