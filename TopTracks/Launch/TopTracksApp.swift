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
      } else {
        switch musicAuthorizationStatus {
        case .authorized:
          AppleMusicSubscriptionView()
        default:
          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
        }
      }
    }
  }
}
