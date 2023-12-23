public enum Constants {}
import Foundation
#if os(iOS)
import UIKit
#endif
import SwiftUI


extension Constants {
  #if os(tvOS)
  public static let playlistGridImageSize = 200.0
  public static let playlistGridGridSize = 240.0
  public static let playlistGridRowSpacing = 40.0
  #elseif os(iOS)
  public static let playlistGridImageSize =  max(UIScreen.main.bounds.width * 1 / 4, 120)
  public static let playlistGridGridSize = max(UIScreen.main.bounds.width * 1 / 3, 140)
  public static let playlistGridRowSpacing = 20.0
  #endif
  
//  public static let playlistListImageSize = 80.0 // was 60
//  public static let stationListImageSize = 80.0
  
  public static let stationListHorizontalEdgeInset = 6.0
  public static let stationLlistVerticalEdgeInset = 20.0
  public static let fullPlayerSwipe = 80.0

  
  #if os(iOS)
  public static let songListImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let miniPlayerArtworkImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let fullPlayerArtworkImageSize =
  max(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1 / 2, 260)
  public static let playlistListImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let stationListImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
//  public static let fullPlayerSwipe = min(UIScreen.main.bounds.width * 1 / 4, 80)
  
  #elseif os(tvOS)
  public static let playlistListImageSize = 200.0
  public static let stationListImageSize = 180.0
  public static let songListImageSize = 180.0
  public static let miniPlayerArtworkImageSize = 180.0
  public static let fullPlayerArtworkImageSize = 500.0


  
  #else
  public static let miniPlayerArtworkImageSize = 80
  public static let fullPlayerArtworkImageSize = 300
  public static let playlistListImageSize = 80.0 // was 60
  public static let stationListImageSize = 80.0
  public static let songListImageSize = 80.0
//  public static let fullPlayerSwipe = 80
  #endif
  
  public static let anchorPointForPlayerTransition = UnitPoint(x: 0.04, y: 0.98)
  
  public static let previewPlayerBeginsNotification = Notification.Name("PreviewPlayerBegan")
  
  public static let previewPlayerEndsNotification = Notification.Name("PreviewPlayerEnded")

  public static let stationWontPlayNotification = Notification.Name("StationWontPlay")
  public static let stationThatWontPlayKey = "stationThatWontPlay"
  public static let missingArtworkSymbolName = "antenna.radiowaves.left.and.right.circle"
}

