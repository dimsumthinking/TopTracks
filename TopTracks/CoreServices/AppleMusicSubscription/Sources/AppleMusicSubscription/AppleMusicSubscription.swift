import MusicKit
import Combine

@MainActor
public class AppleMusicSubscription: ObservableObject {
  public static var shared = AppleMusicSubscription()
  @Published public private(set) var subscription: MusicSubscription?
  
  private init() {
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
    print("can play content", subscription.canPlayCatalogContent.description)
    return subscription.canPlayCatalogContent
  }
  
  public var canBecomeSubscriber: Bool {
    guard let subscription else {return false}
    print("can subscribe", subscription.canBecomeSubscriber.description)
    return subscription.canBecomeSubscriber
  }
}
