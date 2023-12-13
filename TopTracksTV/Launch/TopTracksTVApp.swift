import SwiftUI
import MusicKit
import PlaylistSongPreview
import AppleMusicAuthorization
import AppleMusicSubscription
import ApplicationState


@main
struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @Environment(\.scenePhase) private var scenePhase
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @State private var canPlayCatalogContent = false
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
        switch musicAuthorizationStatus {
        case .authorized:
          if canPlayCatalogContent {
            MainView()
              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
          } else {
            AppleMusicSubscriberView()
              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
          }
        default:
          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
            .preferredColorScheme(currentColorScheme(from: colorSchemeString))
      }
    }
    .onChange(of: musicAuthorizationStatus) { oldStatus, newStatus in
      if newStatus == .authorized {
        Task {
          await checkSubscription()
        }
      }
    }
    .onChange(of: scenePhase) { oldPhase, newPhase in
      if newPhase == .background {
        songPreviewPlayer.stop()
      }
    }
  }
}

extension TopTracksApp {
  private func checkSubscription() async {
    for await canPlayCatalogContent in
          MusicSubscription.subscriptionUpdates.map(\.canPlayCatalogContent) {
      self.canPlayCatalogContent = canPlayCatalogContent
    }
  }
}
