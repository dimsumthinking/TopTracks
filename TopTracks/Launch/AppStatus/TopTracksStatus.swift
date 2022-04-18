import Combine
import MusicKit
import Network
import SwiftUI

class TopTracksStatus: ObservableObject {
  @Published var isCreatingNew = false
  @Published var musicSubscription: MusicSubscription?
  @Published var needsAppSubscription = false
  @AppStorage("requiresWiFi") private var requiresWiFi = false
  private var pathMonitor = NWPathMonitor()
//  init() {
//    configurePathMonitor()
//  }
}
//
//extension TopTracksStatus {
//  private func configurePathMonitor() {
//    pathMonitor.pathUpdateHandler = {path in
//      switch path.status {
//      case:
//      }
//    }
//  }
//}


