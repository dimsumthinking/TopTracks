import Combine
import MusicKit
import Network
import SwiftUI
import RevenueCat


class TopTracksStatus: ObservableObject {
  @Published private(set) var appActivity: TopTracksAppActivity = .playing
  @Published var musicSubscription: MusicSubscription?
  private let pathMonitor = NWPathMonitor()
  @Published private(set) var isNotConnected = true
  @Published private(set) var isExpensive = false
  private var revenueCatSubscription = RevenueCatSubscription()
  
  init() {
    configurePathMonitor()
  }
}

@MainActor
extension TopTracksStatus {
  var activeAppSubscriptionType: AppSubscriptionType {
    revenueCatSubscription.activeAppSubscriptionType
  }
  var hasAppSubscription: Bool {
    revenueCatSubscription.hasAppSubscription
  }
  var activeAppExpirationDate: Date? {
    revenueCatSubscription.activeAppExpirationDate
  }
  func appPrice(for type: AppSubscriptionType) -> String {
    revenueCatSubscription.appPrice(for: type)
  }
  func purchase(subscription appSubscriptionType: AppSubscriptionType) {
    revenueCatSubscription.purchaseSubscription(for: appSubscriptionType)
  }
  func refreshSubscriptions() async {
    await revenueCatSubscription.refreshCustomerInfo()
  }
  func restorePurchases() {
    revenueCatSubscription.restoreSubscriptions()
  }
}

extension TopTracksStatus {
  private func configurePathMonitor() {
    pathMonitor.pathUpdateHandler = {path in
      DispatchQueue.main.async {
        self.isNotConnected = (path.status == .satisfied) ? false : true
        self.isExpensive = path.isExpensive
      }
    }
    let queue = DispatchQueue(label: "Monitor")
    pathMonitor.start(queue: queue)
  }
}

extension TopTracksStatus {
  func startCreating() {
    appActivity = .creating
  }
  func stopCreating() {
    appActivity = .playing
  }
  func startImporting(url: URL?) {
    appActivity = .importing(url: url)
  }
  func stopImporting() {
    appActivity = .playing
  }
  var isImporting: Bool {
    appActivity != .importing(url: URL(string: ""))
  }
}
