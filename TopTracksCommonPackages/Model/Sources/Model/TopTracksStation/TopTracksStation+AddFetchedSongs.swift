import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func add(songs songsToAdd: [Song]) throws {
    throw TTImplementationError.notImplementedYet
  }
  
  private var addedStack: TopTracksStack  {
    get throws {
      throw TTImplementationError.notImplementedYet
    }
  }
  
}




//import SwiftData
//import MusicKit
//import Foundation
//
//extension TopTracksStation {
//  public func add(songs songsToAdd: [Song]) {
//    var added: TopTracksStack
//    if let addedStack = stack(for: .added) {
//      added = addedStack
//    } else {
//      added = TopTracksStack(category: .added)
//      added.station = self
//      do {
//        try context?.save()
//        stationLastUpdated = Date()
//      } catch {
//        print("Couldn't add added stack")
//      }
//    }
//
//
//    let ids = availableSongs.map(\.songID)
//    for song in songsToAdd {
//      if !ids.contains(song.id.rawValue) {
//        let topTracksSong = TopTracksSong(song: song)
//        added.songs?.append(topTracksSong)
//        topTracksSong.stack = added
//
//      }
//    }
//    do {
//    try context?.save()
//  } catch {
//    print("Couldn't save after adding songs to playlist")
//  }
//}
//
//}







//import SwiftData
//import MusicKit
//import Foundation
//
//extension TopTracksStation {
//  public func add(songs songsToAdd: [Song]) {
//    var added: TopTracksStack
//    if let addedStack = stack(for: .added) {
//      added = addedStack
//    } else {
//      added = TopTracksStack(category: .added)
//      added.station = self
//      do {
//        try context?.save()
//        stationLastUpdated = Date()
//      } catch {
//        print("Couldn't add added stack")
//      }
//    }
//    
//    
//    let ids = availableSongs.map(\.songID)
//    for song in songsToAdd {
//      if !ids.contains(song.id.rawValue) {
//        let topTracksSong = TopTracksSong(song: song)
//        added.songs?.append(topTracksSong)
//        topTracksSong.stack = added
//        
//      }
//    }
//    do {
//      try context?.save()
//    } catch {
//      print("Couldn't save after adding songs to playlist")
//    }
//  }
//  
//  private var addedStack: TopTracksStack {
//    if let added = stack(for: .added) {
//      return added
//    } else {
//      let added = TopTracksStack(category: .added)
//      added.station = self
//      stationLastUpdated = Date()
//      do {
//        try context?.save()
//      } catch {
//        print("Couldn't add added stack")
//      }
//    }
//  }
//  
//}
//
//
//
//
////import SwiftData
////import MusicKit
////import Foundation
////
////extension TopTracksStation {
////  public func add(songs songsToAdd: [Song]) {
////    var added: TopTracksStack
////    if let addedStack = stack(for: .added) {
////      added = addedStack
////    } else {
////      added = TopTracksStack(category: .added)
////      added.station = self
////      do {
////        try context?.save()
////        stationLastUpdated = Date()
////      } catch {
////        print("Couldn't add added stack")
////      }
////    }
////
////
////    let ids = availableSongs.map(\.songID)
////    for song in songsToAdd {
////      if !ids.contains(song.id.rawValue) {
////        let topTracksSong = TopTracksSong(song: song)
////        added.songs?.append(topTracksSong)
////        topTracksSong.stack = added
////
////      }
////    }
////    do {
////    try context?.save()
////  } catch {
////    print("Couldn't save after adding songs to playlist")
////  }
////}
////
////}
//
//
//
//
//
