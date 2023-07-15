import SwiftUI
import MusicKit
import NetworkMonitor
import PlaylistSongPreview
import AppleMusicAuthorization
import AppleMusicSubscription
import ApplicationState
import Model
import SwiftData


@main
 struct TopTracksApp {
  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
  @State private var canPlayCatalogContent = false
  
  @State private var networkMonitor = NetworkConnectionMonitor.shared
  @Environment(\.scenePhase) private var scenePhase
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
//  let container = try! ModelContainer(for: Schema([TopTracksStation.self,
//                                                   TopTracksStack.self,
//                                                   TopTracksSong.self]),
//                                      ModelConfiguration(cloudKitContainerIdentifier: "iCloud.com.dimsumthinking.TopTracks"))
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      if networkMonitor.isNotConnected {
        OfflineWarningView()
          .preferredColorScheme(currentColorScheme(from: colorSchemeString))
      } else {
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
    }
    .modelContainer(CommonContainer.shared.container)
//    .modelContainer(for: TopTracksStation.self)
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
