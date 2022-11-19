import SwiftUI
import MusicKit


public struct AppleMusicSubscriptionView {
  let subscription: MusicSubscription?
  @State private var isShowingSubscriptionOffer = false
}

extension AppleMusicSubscriptionView: View {
  public var body: some View {
    VStack(spacing: 40) {
      Text("""
           This app requires an
           Apple Music Subscription
           Individual, Student, or Family Plan
           to create playlists and play music.
           """)
      .multilineTextAlignment(.center)
      if canBecomeSubscriber {
        Button("Subscribe") {
          isShowingSubscriptionOffer = true
        }
      }
    }
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
  }
}

extension AppleMusicSubscriptionView {
  private var canBecomeSubscriber: Bool {
    guard let subscription else {return false}
    return subscription.canBecomeSubscriber
  }
}

