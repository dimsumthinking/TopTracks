import SwiftUI
import MusicKit


public struct AppleMusicSubscriberView {
  @State private var isShowingSubscriptionOffer = false
  @State private var canBecomeSubscriber = false
  @State private var cannotShowContent = false
  public init() {}
//  @ObservedObject private var appleMusicSubscription: AppleMusicSubscription
  
//  public init(appleMusicSubscription: AppleMusicSubscription) {
//    self.appleMusicSubscription = appleMusicSubscription
//  }
}

extension AppleMusicSubscriberView: View {
  public var body: some View {
    VStack(spacing: 40) {
      if cannotShowContent {
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
      if canBecomeSubscriber {
        Button("Subscribe") {
          isShowingSubscriptionOffer = true
        }
      }
    }
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
    .task {
      for await canBecomeSubscriber in AppleMusicSubscription.shared.subscriberPermissions {
        self.canBecomeSubscriber = canBecomeSubscriber
      }
    }
    .task {
      for await canShowContent in AppleMusicSubscription.shared.contentChecksForSubscription {
        self.cannotShowContent = !canShowContent
      }
    }
  }
}

