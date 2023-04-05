import MusicKit

@MainActor
public class AppleMusicSubscription {
  public static var shared = AppleMusicSubscription()
  private var isListeningForSubscriptions = false
  
  public var contentPermissions = MusicSubscription.subscriptionUpdates.map(\.canPlayCatalogContent)
  var subscriberPermissions = MusicSubscription.subscriptionUpdates.map(\.canBecomeSubscriber)
  public var contentChecksForSubscription = MusicSubscription.subscriptionUpdates.map(\.canPlayCatalogContent)
}

//extension AppleMusicSubscription {
//  public var canPlayCatalogContent: Bool {
//    guard let subscription else {return false}
//    print("can play content", subscription.canPlayCatalogContent.description)
//    return subscription.canPlayCatalogContent
//  }
//  
//  public var canBecomeSubscriber: Bool {
//    guard let subscription else {return false}
//    print("can subscribe", subscription.canBecomeSubscriber.description)
//    return subscription.canBecomeSubscriber
//  }
//}
