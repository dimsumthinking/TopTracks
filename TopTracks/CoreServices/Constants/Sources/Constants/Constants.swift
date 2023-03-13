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
  
  public static let playlistListImageSize = 80.0 // was 60
  public static let stationListImageSize = 80.0
  
  public static let stationListHorizontalEdgeInset = 6.0
  public static let stationLlistVerticalEdgeInset = 20.0
  
  
  #if os(iOS)
  public static let miniPlayerArtworkImageSize = min(UIScreen.main.bounds.width * 1 / 6, 80)
  public static let fullPlayerArtworkImageSize = min(UIScreen.main.bounds.width * 2 / 3, 300)
  public static let fullPlayerSwipe = min(UIScreen.main.bounds.width * 1 / 4, 40)


  #else
  public static let miniPlayerArtworkImageSize = 80
  public static let fullPlayerArtworkImageSize = 300
  public static let fullPlayerSwipe = 40
  #endif
  
  public static let anchorPointForPlayerTransition = UnitPoint(x: 0.04, y: 0.98)

}

