import SwiftUI

struct ControlPanel: View {
  
}

extension ControlPanel {
  var body: some View {
    HStack {
      PreviousSongButton()
        .font(.title2)
      Spacer()
      PlayPauseButton()
      Spacer()
      NextSongButton()
        .font(.title2)
    }
    .font(.largeTitle)
    .tint(.primary)
    .padding()
    .padding(.horizontal)
  }
}


//          Spacer()
//          RoutePicker()
//            .frame(width: 20, height: 20)
//          Spacer()
//          Button {
//            ApplicationMusicPlayer.shared.playbackTime = min(duration, ApplicationMusicPlayer.shared.playbackTime + 30)
//          } label: {
//            Image(systemName: "goforward.30")
//          }
