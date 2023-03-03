import SwiftUI
import MusicKit


public struct AppleMusicSubscriberView {
  let canBecomeSubscriber: Bool
  @State private var isShowingSubscriptionOffer = false
  
  public init(canBecomeSubscriber: Bool) {
    self.canBecomeSubscriber = canBecomeSubscriber
  }
}

extension AppleMusicSubscriberView: View {
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


