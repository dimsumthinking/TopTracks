import SwiftUI
import MusicKit


public struct AppleMusicSubscriberView {
  @State private var isShowingSubscriptionOffer = false
  @ObservedObject private var appleMusicSubscription: AppleMusicSubscription
  
  public init(appleMusicSubscription: AppleMusicSubscription) {
    self.appleMusicSubscription = appleMusicSubscription
  }
}

extension AppleMusicSubscriberView: View {
  public var body: some View {
    VStack(spacing: 40) {
      if let subscription = AppleMusicSubscription.shared.subscription {
        Text("""
           This app requires an
           Apple Music Subscription
           Individual, Student, or Family Plan
           to create playlists and play music.
           """)
        .multilineTextAlignment(.center)
      } else {
        VStack {
          Text("Checking Apple Music Subscription")
          ProgressView()
        }
      }
      if appleMusicSubscription.canBecomeSubscriber {
        Button("Subscribe") {
          isShowingSubscriptionOffer = true
        }
      }
    }
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
  }
}

