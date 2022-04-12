import SwiftUI
import MusicKit

struct StationIconView {
  let station: TopTracksStation
}

extension StationIconView: View {
  var body: some View {
    Group {
      if station.stationType  == .playlist {
        playlistIcon
      } else if station.stationType == .station {
        stationIcon
      } else {
        chartIcon
      }
    }
//    .frame(width: stationListCellWidth, alignment: .center)
//    .padding()
  }
}

extension StationIconView {
  private var playlistIcon: some View {
    Group {
      if let artwork = station.playlistInfo?.artwork {
        ArtworkImage(artwork, width: stationListCellWidth)
      } else {
        Image(systemName: TopTracksStationType.playlist.imageName)
          .resizable()
          .scaledToFit()
          .scaleEffect(0.5)
          .foregroundColor(.secondary)
      }
    }
  }
  
  private var chartIcon: some View {
    if let chartType = station.chartType {
      return Image(systemName: chartType.imageName)
        .resizable()
        .scaledToFit()
        .scaleEffect(0.5)
        .foregroundColor(chartType.imageColor)
    } else {
      return Image(systemName: TopTracksStationType.chart.imageName)
        .resizable()
        .scaledToFit()
        .scaleEffect(0.5)
        .foregroundColor(.secondary)
    }
  }
  
  private var stationIcon: some View {
    return Image(systemName: TopTracksStationType.station.imageName)
      .resizable()
      .scaledToFit()
      .scaleEffect(0.5)
//      .foregroundColor(.secondary)
  }
}


//struct StationIconView_Previews: PreviewProvider {
//  static var previews: some View {
//    StationIconView()
//  }
//}
