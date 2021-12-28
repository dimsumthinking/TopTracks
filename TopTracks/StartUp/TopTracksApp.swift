import SwiftUI
import MusicKit

@main
struct TopTracksApp: App {
  @State private(set) var authorization = MusicAuthorization.Status.notDetermined
  //    @State private(set) var subscription: MusicSubscription?
  
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      switch authorization {
      case .notDetermined:
        AuthorizationView(authorization: $authorization)//,
        //                          subscription: $subscription)
      case .denied, .restricted:
        ReconsiderAuthorizationView(authorization: $authorization)
      case .authorized:
        //        if let subscription = subscription,
        //           subscription.canPlayCatalogContent {
        MainView()
          .environmentObject(StationContructionStatus())
          .environment(\.managedObjectContext,
                        PersistenceController.shared.container.viewContext)
          .navigationViewStyle(.stack)
        //        } else {
        //          LocalMusicOnlyView()
        //          Text("Local")
        //        }
      @unknown default:
        Text("The status: \(authorization.rawValue) is not yet handled by this app")
      }
    }
  }
}
