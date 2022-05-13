import SwiftUI
import MusicKit

struct StationPreviewForPlaylist {
  let chartType: TopTracksChartType
  let playlist: Playlist
  @State var songsInCategories: [SongInCategory] = []
}

extension StationPreviewForPlaylist: View {
  var body: some View {
    VStack {
      StationCreationForPlaylistChart(chartType: chartType,
                                      playlist: playlist,
                                      songsInCategories: songsInCategories)
      StationSongsPreview(songsInCategories: songsInCategories)
    }
    .onAppear {
      Task {
        songsInCategories = await StationFiller.rotation(for: playlist)
      }
    }
    .navigationTitle(playlistName)
    .navigationBarBackButtonHidden(true)
//    .modifier(NewStationCancellation())
  }
}

extension StationPreviewForPlaylist {
  private var playlistName: String {
    playlist.name
      .replacingOccurrences(of: "Top 100:", with: "")
      .replacingOccurrences(of: "Top 25:", with: "")
  }
}

//struct ChartPreviewCity_Previews: PreviewProvider {
//  static var previews: some View {
//    ChartPreviewCity()
//  }
//}


