import Model
import Foundation
import Observation

@Observable
public class CurrentStation {
  public static let shared = CurrentStation()
  public internal(set) var nowPlaying: TopTracksStation?
  
//  public internal(set) var topTracksStation: TopTracksStation? {
//    didSet {
//      if let topTracksStation {
//        continuation?.yield(topTracksStation)
//      }
//    }
//  }
//  private var hasNoStreamSubscriber = true
//  
//  private var continuation: AsyncStream<TopTracksStation>.Continuation?
}

//extension CurrentStation {
//  public func currentStationStream() throws -> AsyncStream<TopTracksStation> {
//    guard hasNoStreamSubscriber else {
//      throw HasCurrentStationStreamSubscriber()
//    }
//    return AsyncStream(TopTracksStation.self) { continuation in
//      self.continuation = continuation
//    }
//  }
//}

extension CurrentStation {
  public func setStation(to station: TopTracksStation) {
    station.lastTouched = Date()
    nowPlaying = station
//    fatalError("last touched in station inaccessible and saveInContext not here")
//    station.lastTouched = Date()
//    do {
//      try station.saveInContext()
//      topTracksStation = station
//    }
//    catch {
//      sharedViewContext.rollback()
//      print("Couldn't save station starting to play")
//    }
  }
}

extension CurrentStation {
  public func noStationSelected() {
   nowPlaying = nil
    CurrentSong.shared.noSongSelected()
  }
  public var canShowRating: Bool {
    guard let nowPlaying else { return false }
    return !nowPlaying.isChart
  }
}









public struct HasCurrentStationStreamSubscriber: Error {}

//import Model
//import Foundation
//
//public class CurrentStation {
//  public static let shared = CurrentStation()
//  public internal(set) var topTracksStation: TopTracksStation? {
//    didSet {
//      if let topTracksStation {
//        continuation?.yield(topTracksStation)
//      }
//    }
//  }
//  private var hasNoStreamSubscriber = true
//  
//  private var continuation: AsyncStream<TopTracksStation>.Continuation?
//}
//
//extension CurrentStation {
//  public func currentStationStream() throws -> AsyncStream<TopTracksStation> {
//    guard hasNoStreamSubscriber else {
//      throw HasCurrentStationStreamSubscriber()
//    }
//    return AsyncStream(TopTracksStation.self) { continuation in
//      self.continuation = continuation
//    }
//  }
//}
//
//extension CurrentStation {
//  public func setStation(to station: TopTracksStation) {
//    fatalError("last touched in station inaccessible and saveInContext not here")
////    station.lastTouched = Date()
////    do {
////      try station.saveInContext()
////      topTracksStation = station
////    }
////    catch {
////      sharedViewContext.rollback()
////      print("Couldn't save station starting to play")
////    }
//  }
//}
//
//extension CurrentStation {
//  public func noStationSelected() {
//   topTracksStation = nil
//    CurrentSong.shared.noSongSelected()
//  }
//  public var canShowRating: Bool {
//    guard let topTracksStation else { return false }
//    return !topTracksStation.isChart
//  }
//}
//
//
//
//
//
//
//
//
//
//public struct HasCurrentStationStreamSubscriber: Error {}
//
