import Foundation
import RevenueCat

enum AppSubscriptionType: Int, CaseIterable {
  case none
  case monthly
  case yearly
}

extension AppSubscriptionType: CustomStringConvertible {
  var description: String {
    switch self {
    case .none: return "No"
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
  var packageIdentifier: String? {
    switch self {
    case .monthly: return revenueCatMonthlyPackageID
    case .yearly: return revenueCatYearlyPackageID
    default: return nil
    }
  }
  
  func package(for currentOffering: Offering?) -> Package? {
    switch self {
    case .monthly: return currentOffering?.monthly
    case .yearly: return currentOffering?.annual
    default: return nil
    }
  }
}

extension AppSubscriptionType {
  var currentLevelTextStart: String {
    switch self {
    case .none:
      return "You can create and enjoy up to three stations without any subscription at all."
    case .monthly:
      return "You can create and enjoy unlimited stations."
    case .yearly:
      return "You can create and enjoy unlimited stations."
    }
  }
  var currentLevelTextFinish: String {
    switch self {
    case .none:
      return "For unlimited stations, consider one of the subscriptions below."
    case .monthly:
      return "Upgrade to the yearly subscription to get two months each year for free."
    case .yearly:
      return "No upgrades available."
    }
  }
  
  func cancelByText(expirationDate: Date?) -> String {
    guard let expirationDate = expirationDate,
          self != .none else  {return ""}
    let expirationDateAsString = dateFormatter.string(from: expirationDate)
    return "The current subscription automatically renews on \(expirationDateAsString) unless you cancel."
  }
  
  var subscriptionOffers: [AppSubscriptionType]? {
    switch self {
    case .none: return [.monthly, .yearly]
    case .monthly: return [.yearly]
    case .yearly: return nil
    }
  }
  
  var subscriptionLength: String {
    switch self {
    case .none: return "--"
    case .monthly: return "month"
    case .yearly: return "year"
    }
  }
}

extension AppSubscriptionType: Identifiable {
  var id: Int {
    rawValue
  }
}

fileprivate let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  formatter.timeStyle = .none
  return formatter
}()
