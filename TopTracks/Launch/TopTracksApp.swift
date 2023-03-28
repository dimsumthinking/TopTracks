import SwiftUI
import MusicKit
import NetworkMonitor
import PlaylistSongPreview
import AppleMusicAuthorization
import AppleMusicSubscription
import ApplicationState


@main
struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @StateObject private var networkMonitor = NetworkConnectionMonitor.shared
  @StateObject private var  musicSubscription = AppleMusicSubscription.shared
  @Environment(\.scenePhase) private var scenePhase
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      if networkMonitor.isNotConnected {
        // MARK: - Display no Network
        OfflineWarningView()
          .preferredColorScheme(.dark)
      } else {
        switch musicAuthorizationStatus {
        case .authorized:
          if musicSubscription.canPlayCatalogContent {
            // MARK: - Everything is great  Main App Entry point
            MainView()
              .environmentObject(ApplicationState.shared)
              .preferredColorScheme(.dark)
          } else {
            // MARK: - Checking on Apple Music Subscription
//            AppleMusicSubscriberView(canBecomeSubscriber: musicSubscription.canBecomeSubscriber)
            AppleMusicSubscriberView(appleMusicSubscription: musicSubscription)

          }
        default:
          // MARK: - Checking User Authorized Music
          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
            .preferredColorScheme(.dark)
        }
      }
    }
    .onChange(of: scenePhase) {phase in
      if phase == .background {
        songPreviewPlayer.stop()
//        topTracksStatus.stopImporting()
      }
//      currentlyPlaying.hack.toggle()
    }
  }
}
