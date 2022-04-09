enum TopTracksChartType: String {
  case topSongs
  case cityCharts
  case dailyTop100
  case playlists
}

extension TopTracksChartType {
  var blurb: String {
    switch self {
    case .topSongs:
      return "Top Songs\n(by Genre)"
    case .cityCharts:
      return "City Charts\n(Top 25)"
    case .dailyTop100:
      return "Daily Top 100\n(by Country)"
    case .playlists:
      return "Top Playlists\n(Top 100)"
    }
  }
}

extension TopTracksChartType {
  var imageName: String {
    switch self {
    case .topSongs:
      return genreIcon
    case .cityCharts:
      return cityChartIcon
    case .dailyTop100:
      return top100Icon
    case .playlists:
      return topPlaylistsIcon
    }
  }
}

import SwiftUI

extension TopTracksChartType {
  var imageColor: Color {
    switch self {
    case .topSongs:
      return .mint
    case .cityCharts:
      return .purple
    case .dailyTop100:
      return .cyan
    case .playlists:
      return .orange
    }
  }
}

