import SwiftUI

struct ControlPanel {
  
}

extension ControlPanel: View {
  var body: some View {
    HStack {
      PreviousSongButton()
        .font(.title)
      Spacer()
      PlayPauseButton()
      Spacer()
      NextSongButton()
        .font(.title)
    }
    .font(.largeTitle)
    .tint(.primary)
    .padding()
    .padding(.horizontal)
  }
}
