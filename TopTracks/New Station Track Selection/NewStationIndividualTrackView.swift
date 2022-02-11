import SwiftUI

struct NewStationIndividualTrackView {
  @Binding var songAndRating: NewStationSongRating
  @State private var isPlaying = false
}

extension NewStationIndividualTrackView: View {
  var body: some View {
    HStack(spacing: 0) {
      NewStationTrackPreviewPlayerView(song: songAndRating.song,
                                       isPlaying: $isPlaying)
      NewStationTrackRatingView(songAndRating: $songAndRating)
    }
  }
}
