public enum Constants {}
import Foundation
#if os(iOS)
import UIKit
#endif
import SwiftUI


extension Constants {
  public static let songListImageSize = 80.0
  
  public static let playlistGridImageSize = 150.0
  public static let playlistGridGridSize = 180.0
  public static let playlistGridRowSpacing = 50.0
  
//  public static let playlistListImageSize = 80.0 // was 60
//  public static let stationListImageSize = 80.0
  
  public static let stationListHorizontalEdgeInset = 6.0
  public static let stationLlistVerticalEdgeInset = 20.0
  public static let fullPlayerSwipe = 80.0

  
  #if os(iOS)
  public static let miniPlayerArtworkImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let fullPlayerArtworkImageSize =
  max(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1 / 2, 260)
  public static let playlistListImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let stationListImageSize = max(UIScreen.main.bounds.width * 1 / 6, 80)
//  public static let fullPlayerSwipe = min(UIScreen.main.bounds.width * 1 / 4, 80)
  
  
  #else
  public static let miniPlayerArtworkImageSize = 80
  public static let fullPlayerArtworkImageSize = 300
  public static let playlistListImageSize = 80.0 // was 60
  public static let stationListImageSize = 80.0
//  public static let fullPlayerSwipe = 80
  #endif
  
  public static let anchorPointForPlayerTransition = UnitPoint(x: 0.04, y: 0.98)
  
  public static let previewPlayerBeginsNotification = Notification.Name("PreviewPlayerBegan")

}

