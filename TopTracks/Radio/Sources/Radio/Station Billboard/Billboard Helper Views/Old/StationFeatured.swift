import SwiftUI
import Constants
import Foundation

struct StationFeatured: View {
  let featured: String
  let stationName: String
  @State private var unableToPlay = false
}

extension StationFeatured {
  var body: some View {
    Text(unableToPlay ? cantPlayWarning : featured)
//      .font(.caption)
      .multilineTextAlignment(.leading)
      .foregroundStyle(unableToPlay ? Color.primary : Color.secondary)
      .lineLimit(3)
      .task {
        for await stationName in NotificationCenter.default
          .notifications(named: Constants.stationWontPlayNotification)
          .compactMap(\.userInfo)
          .compactMap({$0[await Constants.stationThatWontPlayKey] as? String}) {
          if self.stationName == stationName {
            unableToPlay = true
            try? await Task.sleep(for: .seconds(5))
            unableToPlay = false
            }
          }
      }
  }
}

extension StationFeatured {
  private var cantPlayWarning: String {
    "Unable to play \(stationName). If this problem persists you may have to delete and re-add this station."
  }
}

