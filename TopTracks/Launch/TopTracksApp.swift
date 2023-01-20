import SwiftUI
import MusicKit

@main
struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      switch musicAuthorizationStatus {
      case .authorized:
        AppleMusicSubscriptionView()
      default:
        AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
      }
    }
  }
}
