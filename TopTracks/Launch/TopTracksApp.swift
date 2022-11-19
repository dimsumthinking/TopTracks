import SwiftUI
import MusicKit
import AppleMusicSubscription

@main
struct TopTracksApp {
  @StateObject private var musicAuthorization = AppleMusicAuthorization()
  @StateObject var musicSubscription = AppleMusicSubscription()
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      switch musicAuthorization.status {
      case .authorized:
        if musicSubscription.canPlayCatalogContent {
          MainView()
        } else {
          musicSubscription.view
        }
      default:
        musicAuthorization.view
      }
    }
  }
}

