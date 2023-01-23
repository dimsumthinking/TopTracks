import MusicKit
import SwiftUI

@MainActor
public class AppleMusicSubscription: ObservableObject {
  public static var shared = AppleMusicSubscription()
//  private var isNotYetMonitoring = true
  
  @Published public private(set) var subscription: MusicSubscription?
  
  private init() {
    Task {
      for await subscription in MusicSubscription.subscriptionUpdates {
        self.subscription = subscription
      }
    }
  }
  
//  public func startMonitoring() {
//    guard isNotYetMonitoring else { return }
//    Task {
//      for await subscription in MusicSubscription.subscriptionUpdates {
//        self.subscription = subscription
//      }
//    }
//  }
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
