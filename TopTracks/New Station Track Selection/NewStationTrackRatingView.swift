import SwiftUI

struct NewStationTrackRatingView {
  @Binding var songAndRating: NewStationSongRating
}

extension NewStationTrackRatingView: View {
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text(songAndRating.song.title)
          Text(songAndRating.song.artistName)
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Spacer()
        Text(songAndRating.rating.description)
          .font(.largeTitle)
      }
      Picker("Choose", selection: $songAndRating.rating){
          ForEach(0..<11) {index in
            Text(index.description)
          }
        }
        .pickerStyle(.segmented)
      }
  }
}

