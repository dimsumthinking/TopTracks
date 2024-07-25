import SwiftUI
import MusicKit
import PlaylistSongPreview
import AppleMusicAuthorization
import AppleMusicSubscription
import ApplicationState
import Model
import SwiftData
import Network


@main
 struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @State private var canPlayCatalogContent = false
  
  @Environment(\.scenePhase) private var scenePhase
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
   @State private var networkIsNotConnected = false
   
   

}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      if networkIsNotConnected {
        OfflineWarningView()
          .preferredColorScheme(currentColorScheme(from: colorSchemeString))
      } else {
        switch musicAuthorizationStatus {
        case .authorized:
          if canPlayCatalogContent {
              MainView()
              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
              .task {
                for await path in NWPathMonitor() {
                  networkIsNotConnected = !( path.status == .satisfied)
                }
              }
          } else {
            AppleMusicSubscriberView()
              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
          }
        default:
          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
            .preferredColorScheme(currentColorScheme(from: colorSchemeString))
        }
      }
    }
    .modelContainer(CommonContainer.shared.container)
    //.modelContainer(container)
    .onChange(of: musicAuthorizationStatus, initial: true) { oldStatus, newStatus in
      if newStatus == .authorized {
        Task {
          await checkSubscription()
        }
      }
    }
    .onChange(of: scenePhase, initial: true) { oldPhase, newPhase in
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
