import Foundation
import WatchConnectivity
import Model


public class WatchConnector: NSObject, ObservableObject, WCSessionDelegate  {
  public private(set) var setStation: (TopTracksStation) async throws -> Void
  @Published public private(set) var topTrackStations: [TopTracksStation] = []
  @Published public private(set) var selectedStation: TopTracksStation?
  
  public init(action setStation: @escaping (TopTracksStation) async throws -> Void ) {
    self.setStation = setStation
    super.init()
    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
}

extension WatchConnector { // messages to send
  public func setSelectedStation(to selectedStation: TopTracksStation) {
    RadioWatchLogger.sendingAndPlayingSelectedStation.info("Sending selected station")
    transferUserInfo(["selectedStation": selectedStation])
  }
  
#if os(iOS)
  public func setStations(to topTrackStations: [TopTracksStation]) {
    RadioWatchLogger.sendingStations.info("Sending station list")
    self.topTrackStations = topTrackStations
//    transferUserInfo(["stations": topTrackStations])
  }
#endif
  
#if os(watchOS)
//  public func requestStations() {
//    let session = WCSession.default
//    
//    if session.activationState == .activated {
//      session.sendMessage(["request": "stations"], replyHandler: transferUserInfo)
//    }
//  }
  
  public func requestRandomStation() {
    let session = WCSession.default
    
    if session.activationState == .activated {
      session.transferUserInfo(["selectStation": "none" ])
      RadioWatchLogger.selectingStation.info("Requesting random station")

    }
  }
  
  public func request(station: TopTracksStation) {
    let session = WCSession.default
    
    if session.activationState == .activated {
      session.transferUserInfo(["selectStation": station.stationName ])
      RadioWatchLogger.selectingStation.info("Requesting station \(station.name)")
    }
  }
#endif
}

extension WatchConnector {
#if os(iOS)
  func transferUserInfo(_ userInfo: [String: Any]) {
    let session = WCSession.default
    
    if session.activationState == .activated &&
        session.isWatchAppInstalled && session.isPaired && session.isReachable {
      session.transferUserInfo(userInfo)
    }
  }
#else
  func transferUserInfo(_ userInfo: [String: Any]) {
    let session = WCSession.default
    
    if session.activationState == .activated {
      session.transferUserInfo(userInfo)
    }
  }
#endif
}

#if os(iOS)
extension WatchConnector {
  public func session(_ session: WCSession,
                      didReceiveUserInfo userInfo: [String: Any] = [:]) {
    RadioWatchLogger.connecting.info("Session activation state: \(session.activationState == WCSessionActivationState.activated) (on iOS)")
    
    Task { @MainActor in
      if let stationName = userInfo["selectStation"] as? String {
        if stationName == "none" { await playRandomStation() }
        else { await playStation(named: stationName)}
      }
    }
  }
        
  private func playStation(named name: String) async {
    if let station = topTrackStations.first(where: { $0.name == name}) {
      do {
        try await setStation(station)
        await MainActor.run {
          self.selectedStation = station
        }
        RadioWatchLogger.selectingStation.info("Selected station \(station.name)")
      } catch {
        
        RadioWatchLogger.selectingStation.info("Couldn't play \(station.name)")

      }
    }
  }

  
  private func playRandomStation() async {
      do {
        if let stationToPlay = topTrackStations.randomElement() {
          try await setStation(stationToPlay)
          await MainActor.run {
            self.selectedStation = stationToPlay
          }
          RadioWatchLogger.receivingStations.info("Playing random station")
          
        }
      } catch {
        RadioWatchLogger.receivingStations.info("Couldn't play random station")
      }
  }

  
//  public func session(_ session: WCSession,
//                      didReceiveUserInfo userInfo: [String: Any] = [:]) {
//    RadioWatchLogger.connecting.info("Session activation state: \(session.activationState == WCSessionActivationState.activated) (on iOS)")
//    
//    Task { @MainActor in
//      if let selectedStation = userInfo["selectStation"] as? TopTracksStation {
//        let context = CommonContainer.shared.container.mainContext
//        do {
//          if let stationToSet = context.model(for: selectedStation.persistentModelID) as? TopTracksStation {
//            self.selectedStation = stationToSet
//            try await setStation(stationToSet)
//            RadioWatchLogger.selectingStation.info("Selected station \(stationToSet.name)")
//          }
//        } catch {
//          RadioWatchLogger.selectingStation.info("Couldn't play \(selectedStation.name)")
//          
//        }
//      } else {
//        do {
//          if let stationToPlay = topTrackStations.randomElement() {
//            self.selectedStation = stationToPlay
//            try await setStation(stationToPlay)
//            RadioWatchLogger.receivingStations.info("Playing random station")
//
//          }
//        } catch {
//          RadioWatchLogger.receivingStations.info("Couldn't play random station")
//        }
//      }
//    }
//  }

  
  
//  public func session(_ session: WCSession,
//                      didReceiveMessage message: [String: Any], 
//                      replyHandler: @escaping ([String: Any]) -> Void) {
//    Task { @MainActor in
//      RadioWatchLogger.receivingStations.info("Got request for stations")
//      if let messageText = message["request"] as? String,
//         messageText == "stations" {
//        transferUserInfo(["stations": self.topTrackStations])
//      }
//    }
//  }
}
#endif



extension WatchConnector {
  
#if os(iOS)
  
  public func session(_ session: WCSession,
                      activationDidCompleteWith
                      activationState: WCSessionActivationState, error: Error?) {
    Task { @MainActor in
      if activationState == .activated {
        if session.isWatchAppInstalled {
          RadioWatchLogger.connecting.info("Connected to AppleWatch")
          
//          transferUserInfo(["stations": topTrackStations])
//          if let selectedStation {
//            transferUserInfo(["selectedStation": selectedStation])
//          }
        } else {
          RadioWatchLogger.connecting.info("Not connected to AppleWatch")
        }
      }
    }
  }
  
  public func sessionDidBecomeInactive(_ session: WCSession) {
    RadioWatchLogger.connecting.info("Session did become inactive")
    
  }
  
  public func sessionDidDeactivate(_ session: WCSession) {
    session.activate()
    RadioWatchLogger.connecting.info("Session did deactivate")
    
  }
#else
  public func session(_ session: WCSession,
                      activationDidCompleteWith
                      activationState: WCSessionActivationState, error: Error?) {
    if activationState == .activated {
      RadioWatchLogger.connecting.info("Connected to iOS device")
//      requestStations()
    } else {
      RadioWatchLogger.connecting.info(("not connected to iOS device"))
    }
  }
#endif
  
  
}
