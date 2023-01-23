import SwiftUI
import MusicKit

public struct BasicPlayerControlView {
  @ObservedObject private var state = ApplicationMusicPlayer.shared.state
  public init(){}
  
}

extension BasicPlayerControlView: View {
  public var body: some View {
    HStack {
      Spacer()
      Button(action: Player.shared.previousSong) {
        Image(systemName: "backward.fill")
      }
      Spacer()
      if state.playbackStatus == .playing {
        Button(action: Player.shared.pause) {
          Image(systemName: "pause.fill")
        }
      } else {
        Button(action: Player.shared.play) {
          Image(systemName: "play.fill")
        }
      }
      Spacer()
      Button(action: Player.shared.nextSong) {
        Image(systemName: "forward.fill")
      }
      Spacer()
    }
    .font(.title)
    .foregroundColor(.secondary)
  }
}
