import SwiftUI
import MusicKit

struct NewStationSongRatingView {
  let song: Song
  @Binding var rating: Int
}

extension NewStationSongRatingView: View {
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        AppleMusicPlaylistSongPreviewView(song: song)
        Spacer()
        Text(rating.description)
          .font(.title)
          .foregroundColor(.secondary)
        
      }
      Picker("Choose", selection: $rating){
        ForEach(0..<11) {index in
          Text(index.description)
        }
      }.pickerStyle(.segmented)
        .padding(.bottom)
    }
  }
}
//
//struct NewStationSongRatingView_Previews: PreviewProvider {
//  static var previews: some View {
//    NewStationSongRatingView()
//  }
//}
