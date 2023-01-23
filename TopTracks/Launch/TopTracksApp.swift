import SwiftUI
import MusicKit
import NetworkMonitor

@main
struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @StateObject private var networkMonitor = NetworkConnectionMonitor.shared
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      if networkMonitor.isNotConnected {
        OfflineWarningView()
          .preferredColorScheme(.dark)
      } else {
        switch musicAuthorizationStatus {
        case .authorized, .notDetermined:
          AppleMusicSubscriptionView()
            .preferredColorScheme(.dark)
        default:
          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
            .preferredColorScheme(.dark)
        }
      }
    }
  }
}
