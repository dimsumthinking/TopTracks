import SwiftUI

struct ControlPanel {
  
}

extension ControlPanel: View {
  var body: some View {
    HStack {
//      Spacer()
      PreviousSongButton()
      Spacer()
      PlayPauseButton()
      Spacer()
      NextSongButton()
//      Spacer()
    }
    .font(.largeTitle)
    .tint(.primary)
    .padding()
    .padding(.horizontal)
  }
}
