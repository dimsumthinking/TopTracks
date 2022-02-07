import SwiftUI

struct NewStationIndividualTrackView {
  @Binding var songAndRating: NewStationSongRating
}

extension NewStationIndividualTrackView: View {
  var body: some View {
    HStack(spacing: 0) {
      NewStationTrackPreviewPlayerView(song: songAndRating.song)
      NewStationTrackRatingView(songAndRating: $songAndRating)
    }
  }
}
