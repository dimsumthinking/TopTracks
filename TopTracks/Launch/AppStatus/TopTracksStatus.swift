import Combine
import MusicKit
import Network
import SwiftUI

class TopTracksStatus: ObservableObject {
  @Published var isCreatingNew = false
  @Published var musicSubscription: MusicSubscription?
  private let pathMonitor = NWPathMonitor()
  @Published var isNotConnected = true
  @Published var isExpensive = false
  @Published var numberOfStations = 0
  init() {
    configurePathMonitor()
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


