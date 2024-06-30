import SwiftUI
import Constants
import Foundation

struct StationWontPlayView {
  @State private var stationName = ""
  @State private var isHidden  = true
}

extension StationWontPlayView: View {
  var body: some View {
    VStack {
      Text("Unable to play \(stationName)")
        .font(.largeTitle)
        .padding()
      Text("""
           If this problem persists 
           you may have to delete
           and re-add this station.
           """)
      padding()
    }
    .padding()
    .background(.ultraThickMaterial)
    .padding()
    .opacity(isHidden ? 0 : 1)
    .task {
      for await stationName in NotificationCenter.default
        .notifications(named: Constants.stationWontPlayNotification)
        .compactMap(\.userInfo)
        .compactMap({$0[Constants.stationThatWontPlayKey] as? String}) {
        self.stationName = stationName
        isHidden = false
        try? await Task.sleep(for: .seconds(5))
        isHidden = true
        }
    }
  }
}

#Preview {
  StationWontPlayView()
}
