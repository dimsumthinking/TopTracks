import Foundation

enum ActiveAppSubscription {
  case none
  case monthly(expiration: Date, price: String, trial: Bool)
  case yearly(expiration: Date, price: String, trial: Bool)
}

extension ActiveAppSubscription {
  var title: String {
    switch self {
    case .none: return "Title"
    case .monthly(_,_,_): return "Monthly"
    case .yearly(_,_,_): return "Yearly"
    }
  }
  
  var text: String {
    switch self {
    case .none:
      return "Create and enjoy up to three stations for free without any subscription."
    case .monthly(_,_,_):
      return "Enjoy unlimited stations with this monthy subscription."
    case .yearly(_,_,_):
      return "Subscribe for a year and get two months for free."
    }
  }
  
  var expirationDate: String? {
    switch self {
    case .monthly(let date, _,_), .yearly(let date, _,_):
      return dateFormatter.string(for: date) ?? ""
    case .none:
      return nil
    }
  }
  
  var price: String? {
    switch self {
    case .monthly(_, let price,_), .yearly(_, let price,_):
      return price
    case .none:
      return nil
    }
  }
  
  var freeTrial: String? {
    switch self {
    case .monthly(_,_,let trial), .yearly(_,_, let trial):
      if trial {return "Free trial period"} else {return nil}
    default: return nil
    }
  }
}

//extension ActiveAppSubscription {
//  static func activeAppSubscription(entitlement: EntitlementInfo,
//                                    for productIdentifier: String) -> ActiveAppSubscription {
//    switch entitlement.productIdentifier {
//    case "toptracks_099_1month":
//      return .monthly(expiration: entitlement.expirationDate, price: entitlement., trial: <#T##Bool#>)
//    }
//  }
//}


fileprivate let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  formatter.timeStyle = .none
  return formatter
}()

