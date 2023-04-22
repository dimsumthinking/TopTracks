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
//  @StateObject private var  musicSubscription = AppleMusicSubscription.shared
  @Environment(\.scenePhase) private var scenePhase
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @State private var canPlayCatalogContent = false
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
    .onChange(of: musicAuthorizationStatus) { status in
      if status == .authorized {
        Task {
          await checkSubscription()
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

extension TopTracksApp {
  private func checkSubscription() async {
    for await canPlayCatalogContent in
          MusicSubscription.subscriptionUpdates.map(\.canPlayCatalogContent) {
          //AppleMusicSubscription.shared.contentPermissions {
      self.canPlayCatalogContent = canPlayCatalogContent
    }
  }
}


//import SwiftUI
//import MusicKit
//import NetworkMonitor
//import PlaylistSongPreview
//import AppleMusicAuthorization
//import AppleMusicSubscription
//import ApplicationState
//
//
//@main
//struct TopTracksApp {
//  @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined
//  @StateObject private var networkMonitor = NetworkConnectionMonitor.shared
//  @StateObject private var  musicSubscription = AppleMusicSubscription.shared
//  @Environment(\.scenePhase) private var scenePhase
//  @AppStorage("colorScheme") private var colorSchemeString = "dark"
//}
//
//extension TopTracksApp: App {
//  var body: some Scene {
//    WindowGroup {
//      if networkMonitor.isNotConnected {
//        OfflineWarningView()
//          .preferredColorScheme(currentColorScheme(from: colorSchemeString))
//      } else {
//        switch musicAuthorizationStatus {
//        case .authorized:
//          if musicSubscription.canPlayCatalogContent {
//            MainView()
//              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
//          } else {
//            AppleMusicSubscriberView(appleMusicSubscription: musicSubscription)
//              .preferredColorScheme(currentColorScheme(from: colorSchemeString))
//          }
//        default:
//          AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus)
//            .preferredColorScheme(currentColorScheme(from: colorSchemeString))
//        }
//      }
//    }
//
//    .onChange(of: scenePhase) {phase in
//      if phase == .background {
//        songPreviewPlayer.stop()
////        topTracksStatus.stopImporting()
//      }
////      currentlyPlaying.hack.toggle()
//    }
//  }
//}
