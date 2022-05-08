import RevenueCat
import Foundation

class RevenueCatSubscription: ObservableObject {
  @Published private(set) var customerInfo: CustomerInfo?
  private var currentOffering: Offering?
  
  init() {
    Purchases.logLevel = .debug
    Purchases.configure(withAPIKey: revenueCatAPIKey)
    Task {
      await customerInfo()
      currentOffering = try? await Purchases.shared
        .offerings()
        .current
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
  
  func package(for appSubscriptionType: AppSubscriptionType) -> Package? {
    appSubscriptionType.package(for: currentOffering)
  }
  
  
  
  func appPrice(for appSubscriptionType: AppSubscriptionType)  -> String {
    guard let package = package(for: appSubscriptionType)
    else {return appSubscriptionType.description}
    return package.localizedPriceString
    + " / " + appSubscriptionType.subscriptionLength
  }
  
  func purchaseSubscription(for appSubscriptionType: AppSubscriptionType) {
    if let package = package(for: appSubscriptionType) {
      Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
//        if customerInfo.entitlements["your_entitlement_id"]?.isActive == true {
//          // Unlock that great "pro" content
//        }
      }
    }
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
