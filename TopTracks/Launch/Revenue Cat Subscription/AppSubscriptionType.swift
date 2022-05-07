import Foundation

enum AppSubscriptionType: Int, CaseIterable {
  case none
  case monthly
  case yearly
}

extension AppSubscriptionType: CustomStringConvertible {
  var description: String {
    switch self {
    case .none: return "Free"
    case .monthly: return "Monthly"
    case .yearly: return "Yearly"
    }
  }
}

extension AppSubscriptionType {
  var productIdentifier: String? {
    switch self {
    case .monthly: return revenueCatMonthlyProductID
    case .yearly: return revenueCatYearlyProductID
    default: return nil
    }
  }
}

extension AppSubscriptionType {
  var currentLevelText: String {
    switch self {
    case .none:
      return "You can create and enjoy up to three stations. For unlimited stations, consider one of the subscriptions below."
    case .monthly:
      return "You can create and enjoy unlimited stations. Change to the yearly subscription to get two months each year for free."
    case .yearly:
      return "You can create and enjoy unlimited stations."
    }
  }
  
  func cancelByText(expirationDate: String?) -> String? {
    guard let expirationDate = expirationDate else  {return nil}
    return "This \(description) Subscription automatically renews on \(expirationDate) unless you cancel."
  }
  
  var subscriptionOffers: [AppSubscriptionType]? {
    switch self {
    case .none: return [.monthly, .yearly]
    case .monthly: return [.yearly]
    case .yearly: return nil
    }
  }
}

extension AppSubscriptionType: Identifiable {
  var id: Int {
    rawValue
  }
}
