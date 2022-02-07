import SwiftUI
import MusicKit

struct OnBoardingDecadesView {
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension OnBoardingDecadesView: View {
  var body: some View {
    List(appleMusicDecades) {decade in
      NavigationLink(decade.description) {
        OnBoardingPlaylistView(for: decade)
      }
    }
    .navigationTitle("Choose a Decade")
  }
}
