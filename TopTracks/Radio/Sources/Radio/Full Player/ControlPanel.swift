import SwiftUI

struct ControlPanel {
  
}

extension ControlPanel: View {
  var body: some View {
    HStack {
//      Spacer()
      PreviousSongButton()
        .font(.title)
      Spacer()
      PlayPauseButton()
      Spacer()
      NextSongButton()
        .font(.title)
//      Spacer()
    }
    .font(.largeTitle)
    .tint(.primary)
    .padding()
    .padding(.horizontal)
  }
}
