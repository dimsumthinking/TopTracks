import MusicKit
import SwiftUI

@MainActor
public class AppleMusicSubscription: ObservableObject {
  @Published private(set) var subscription: MusicSubscription?
  
  public init() {
    Task {
      for await subscription in MusicSubscription.subscriptionUpdates {
        self.subscription = subscription
      }
    }
  }
}

extension AppleMusicSubscription {
  public var canPlayCatalogContent: Bool {
    guard let subscription else {return false}
    return subscription.canPlayCatalogContent
  }
  
  public var view: some View {
    AppleMusicSubscriptionView(subscription: subscription)
  }
}
