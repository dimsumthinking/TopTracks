import SwiftUI
import MusicKit

@main
struct TopTracksApp {
  @State private var appleMusicAuthorization = MusicAuthorization.Status.notDetermined
  @State private var showAppleMusicSubscriptionView = false
  private var topTracksStatus = TopTracksStatus()
  private var currentlyPlaying = CurrentlyPlaying()
  @Environment(\.scenePhase) var scenePhase

  
  
//    let persistenceController = PersistenceController.shared
}

extension TopTracksApp: App {
  var body: some Scene {
    WindowGroup {
      switch appleMusicAuthorization {
      case .notDetermined:
        AppleMusicAuthorizationView(authorization: $appleMusicAuthorization)
          .preferredColorScheme(.dark)
      case .denied:
        ReconsiderAppleMusicAuthorizationView(authorization: $appleMusicAuthorization)
          .preferredColorScheme(.dark)
      case .restricted:
        RestrictedAppleMusicAuthorizationView()
          .preferredColorScheme(.dark)
      case .authorized:
        mainView
          .preferredColorScheme(.dark)
      @unknown default:
        Text("The status: \(appleMusicAuthorization.rawValue) is not yet handled by this app")
      }
    }
    .onChange(of: scenePhase) {phase in
      if phase == .background {
        songPreviewPlayer.stop()
      }
      currentlyPlaying.hack.toggle()
    }
  }
}


extension TopTracksApp {
  @MainActor
  private func updateSubscription(_ subscription: MusicSubscription) {
    showAppleMusicSubscriptionView = !subscription.canPlayCatalogContent
    topTracksStatus.musicSubscription = subscription
  }
}

extension TopTracksApp {
  private var mainView: some View {
    MainView()
      .environmentObject(topTracksStatus)
      .environment(\.managedObjectContext,
                    PersistenceController.shared.container.viewContext)
      .environmentObject(currentlyPlaying)
      .navigationViewStyle(.stack)
      .task {
        for await subscription in MusicSubscription.subscriptionUpdates {
          await updateSubscription(subscription)
        }
      }
      .sheet(isPresented: $showAppleMusicSubscriptionView,
             onDismiss: {showAppleMusicSubscriptionView = !(topTracksStatus.musicSubscription?.canPlayCatalogContent ?? false)}) {
        AppleMusicSubscriptionView(topTracksStatus: topTracksStatus)
      }
  }
}

