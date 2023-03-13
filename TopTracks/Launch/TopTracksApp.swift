import SwiftUI
import MusicKit
import NetworkMonitor
import Model
import PlaylistSongPreview


@main
struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @StateObject private var networkMonitor = NetworkConnectionMonitor.shared
  let persistence = sharedViewContext
  @Environment(\.scenePhase) private var scenePhase
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      if networkMonitor.isNotConnected {
        OfflineWarningView()
          .preferredColorScheme(.dark)
      } else {
        switch musicAuthorizationStatus {
        case .authorized://, .notDetermined:
          AppleMusicSubscriptionView()
            .preferredColorScheme(.dark)
        default:
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
