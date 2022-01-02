import SwiftUI
import MusicKit

struct StationCreationAndBillboard {
  @State private(set) var playlist: Playlist
  
}

extension StationCreationAndBillboard: View {
  var body: some View {
    NavigationLink {
      StationCreationView(playlist: playlist)
    } label: {
      AppleMusicPlaylistBillboardView(playlist: AppleMusicPlaylistBillboard(playlist: playlist))
    }
    .onAppear {
      Task {
        self.playlist = try await playlist.with([.featuredArtists, .tracks])
      }
    }
  }
}

//struct StationCreationAndBillboard_Previews: PreviewProvider {
//  static var previews: some View {
//    StationCreationAndBillboard()
//  }
//}
