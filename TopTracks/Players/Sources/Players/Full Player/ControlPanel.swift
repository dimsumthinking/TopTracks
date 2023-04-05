import SwiftUI

struct ControlPanel {
  
}

extension ControlPanel: View {
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
