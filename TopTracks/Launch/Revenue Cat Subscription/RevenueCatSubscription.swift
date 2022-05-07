import RevenueCat
import Foundation

class RevenueCatSubscription: ObservableObject {
  @Published private(set) var customerInfo: CustomerInfo?
  
  init() {
    Purchases.logLevel = .debug
    Purchases.configure(withAPIKey: revenueCatAPIKey)
    Task {
      await customerInfo()
      await listenForCustomerInfo()
    }
  }
}

extension RevenueCatSubscription {
  
  var hasAppSubscription: Bool {
    guard let customerInfo = customerInfo else {return false}
    return customerInfo.entitlements.active.keys.contains("unlimited")
  }
  
  var activeEntitlement: EntitlementInfo? {
    guard let activeEntitlements = customerInfo?.entitlements.active else {return nil}
    return activeEntitlements["unlimited"]
  }
  
  var activeAppSubscriptionType: AppSubscriptionType {
    guard let unlimitedEntitlement = activeEntitlement else {return .none}
    switch unlimitedEntitlement.productIdentifier {
    case revenueCatMonthlyProductID: return .monthly
    case revenueCatYearlyProductID: return .yearly
    default: return .none
    }
  }
  
  var activeAppExpirationDate: Date? {
    activeEntitlement?.expirationDate
  }
  
  var activeAppTrialPeriod: Bool {
    activeEntitlement?.periodType == .trial
  }
  
  func appPrice(for productIdentifier: String?) async  -> String? {
    guard let productIdentifier = productIdentifier,
          let package
            = try? await Purchases.shared
      .offerings()
      .current?
      .package(identifier: productIdentifier) else {return nil}
    return package.localizedPriceString
  }
}

extension RevenueCatSubscription {
  private func customerInfo() async {
    self.customerInfo = try? await Purchases.shared.customerInfo()
  }
  
  @MainActor
  private func listenForCustomerInfo() async {
    for await customerInfo in Purchases.shared.customerInfoStream {
      self.customerInfo = customerInfo
    }
  }
}
