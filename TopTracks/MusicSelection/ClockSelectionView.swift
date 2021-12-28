import SwiftUI
import MusicKit

struct ClockSelectionView {
  let playlist: Playlist
}

extension ClockSelectionView: View {
  var body: some View {
    VStack {
      InstructionView("")
    }
  }
}

//struct ClockSelectionView_Previews: PreviewProvider {
//  static var previews: some View {
//    ClockSelectionView()
//  }
//}
