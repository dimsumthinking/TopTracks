import Combine
import MusicKit
import Network
import SwiftUI

class TopTracksStatus: ObservableObject {
  @Published private(set) var appActivity: TopTracksAppActivity = .playing
//  @Published var isCreatingNew = false
  @Published var musicSubscription: MusicSubscription?
  private let pathMonitor = NWPathMonitor()
  @Published private(set) var isNotConnected = true
  @Published private(set) var isExpensive = false
//  @Published var numberOfStations = 0
  @Published private(set) var stationBeingUpdated: TopTracksStation? = nil
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

extension TopTracksStatus {
  func startCreating() {
    appActivity = .creating
  }
  func endCreating() {
    appActivity = .playing
  }
  func startUpdating(_ station: TopTracksStation) {
    appActivity = .updating
    stationBeingUpdated = station
  }
  func stopUpdating() {
    appActivity = .playing
    stationBeingUpdated = nil
  }
}


