import SwiftUI
import MusicKit

@main
struct TopTracksApp: App {
  @State private(set) var authorization = MusicAuthorization.Status.notDetermined
  @State private var showSubscriptionView = false
  @StateObject private var topTracksStatus = TopTracksStatus()
  @Environment(\.scenePhase) var scenePhase
  
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      switch authorization {
      case .notDetermined:
        AuthorizationView(authorization: $authorization)
      case .denied:
        ReconsiderAuthorizationView(authorization: $authorization)
      case .restricted:
        RestrictedAuthorizationView()
      case .authorized:
        MainView()
          .environmentObject(topTracksStatus)
          .environment(\.managedObjectContext,
                        PersistenceController.shared.container.viewContext)
          .navigationViewStyle(.stack)
          .task {
            for await subscription in MusicSubscription.subscriptionUpdates {
              updateSubscription(subscription)
            }
          }
          .sheet(isPresented: $showSubscriptionView,
                 onDismiss: {showSubscriptionView = !(topTracksStatus.musicSubscription?.canPlayCatalogContent ?? false)}) {
            SubscriptionView(topTracksStatus: topTracksStatus)
          }
      @unknown default:
        Text("The status: \(authorization.rawValue) is not yet handled by this app")
      }
    }
    .onChange(of: scenePhase) {phase in
      if phase == .background {
        musicTestPreviewPlayer.audioPlayer = nil
        topTracksStatus.isCreatingNew = false
      }
    }
  }
}

extension TopTracksApp {
  private func updateSubscription(_ subscription: MusicSubscription) {
    showSubscriptionView = !subscription.canPlayCatalogContent
    topTracksStatus.musicSubscription = subscription
  }
}

