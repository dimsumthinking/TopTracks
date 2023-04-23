import SwiftUI
import MusicKit


public struct AppleMusicSubscriberView {
  @State private var isShowingSubscriptionOffer = false
  @State private var canBecomeSubscriber = false
  @State private var cannotShowContent = false
  public init() {}

}

extension AppleMusicSubscriberView: View {
  public var body: some View {
    VStack(spacing: 40) {
      if cannotShowContent {
       AppleMusicSubscriptionCantShowContent()
      } else {
        AppleMusicSubscriptionIsChecking()
      }
      if canBecomeSubscriber {
        Button("Subscribe") {
          isShowingSubscriptionOffer = true
        }
      }
    }
    #if os(iOS) || os(macOS)
    .musicSubscriptionOffer(isPresented: $isShowingSubscriptionOffer,
                            options: MusicSubscriptionOffer.Options.default)
    #endif
    .task {
      for await canBecomeSubscriber in
            MusicSubscription.subscriptionUpdates.map(\.canBecomeSubscriber) {
        self.canBecomeSubscriber = canBecomeSubscriber
      }
    }
    .task {
      for await canPlayCatalogContent in
            MusicSubscription.subscriptionUpdates.map(\.canPlayCatalogContent) {
        self.cannotShowContent = !canPlayCatalogContent
      }
    }
  }
}

struct AppleMusicSubscriberView_Preview: PreviewProvider {
  
  static var previews: some View {
    AppleMusicSubscriberView()
  }
}

