import SwiftUI
import MusicKit
import AppleMusicSubscription
import ApplicationState

struct AppleMusicSubscriptionView {
  @StateObject var musicSubscription = AppleMusicSubscription.shared
}

extension AppleMusicSubscriptionView: View {
    var body: some View {
      if musicSubscription.canPlayCatalogContent ||
          musicSubscription.subscription == nil {
        MainView()
          .environmentObject(ApplicationState.shared)
      } else {
        AppleMusicSubscriberView(canBecomeSubscriber: musicSubscription.canBecomeSubscriber)
      }
    }
}




struct AppleMusicSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
      AppleMusicSubscriptionView()
    }
}
