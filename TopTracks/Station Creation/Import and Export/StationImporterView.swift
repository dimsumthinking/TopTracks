import SwiftUI
import MusicKit

struct StationImporterView {
  let url: URL
  @StateObject var importer = StationImporter()
  //  @StateObject var importer: StationImporter
  
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationImporterView: View {
  var body: some View {
    VStack {
      if let playlist = importer.musicItem as? Playlist {
        if importer.stationType == .chart(chartType: .dailyTop100) {
          StationPreviewForPlaylist(chartType: .dailyTop100,
                                    playlist: playlist)
        } else if  importer.stationType == .chart(chartType: .cityCharts) {
          StationPreviewForPlaylist(chartType: .cityCharts,
                                    playlist: playlist)
        } else {
          //          MusicTestView(for: playlist)
          StationPreviewForPlaylist(chartType: .playlists,
                                    playlist: playlist)
        }
      } else if let genre = importer.musicItem as? Genre {
        StationPreviewForGenre(genre: genre)
      } else if let station = importer.musicItem as? Station {
        StationCreationForAppleMusicStation(station: station)
      } else {
        VStack {
          Text(importer.stationType == stationTypeForDeepLinkNotFound ? "Could not locate station from the provided link" : "Importing Playlist...")
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .foregroundColor(.secondary)
            .padding()
          Button("Dismiss",
                 action: {topTracksStatus.stopImporting()})
          .padding()
        }
      }
    }
    .task {
      await importer.process(url: url)
    }
  }
}

//struct StationImporterView_Previews: PreviewProvider {
//  static var previews: some View {
//    StationImporterView(stationType: .playlist,
//                        musicID: "some id")
//  }
//}
