import SwiftUI
import MusicKit


struct AppleMusicSubscriptionView {
  @ObservedObject private(set) var topTracksStatus: TopTracksStatus
  @State private var isShowingSubscriptionOffer = false
}

extension AppleMusicSubscriptionView: View {
  var body: some View {
    VStack(spacing: 40) {
      Text("""
           This app requires an
           Apple Music Subscription
           Individual, Student, or Family Plan
           to create playlists and play music.
           """)
      .multilineTextAlignment(.center)
      if let subscription = topTracksStatus.musicSubscription,
         subscription.canBecomeSubscriber {
        Button("Subscribe", action: subscribeButtonSelected)
      }
    }
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
  }
}

extension AppleMusicSubscriptionView {
  private func subscribeButtonSelected() {
    isShowingSubscriptionOffer = true
  }
}
