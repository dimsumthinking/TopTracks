import SwiftUI
import MusicKit


struct SubscriptionView {
  @ObservedObject private(set) var topTracksStatus: TopTracksStatus
  @State private var isShowingSubscriptionOffer = false
}

extension SubscriptionView: View {
  var body: some View {
    VStack(spacing: 40) {
      Text("""
           This app requires an
           Individual, Student, or Family Plan
           Apple Music Subscription
           to create playlists and play music.
           """)
        .multilineTextAlignment(.center)
      if let subscription = topTracksStatus.musicSubscription {
        Text(subscription.canBecomeSubscriber.description)
        Text(subscription.canPlayCatalogContent.description)
        if subscription.canBecomeSubscriber {
          Button("Subscribe", action: subscribeButtonSelected)
        }
      }
    }
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
  }
}

extension SubscriptionView {
  private func subscribeButtonSelected() {
    isShowingSubscriptionOffer = true
  }
}
