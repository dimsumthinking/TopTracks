import Foundation
import CoreData
import MusicKit


extension TopTracksSong {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSong> {
    return NSFetchRequest<TopTracksSong>(entityName: "TopTracksSong")
  }
  @NSManaged public var stackPosition: Int16
  @NSManaged public var upOrDown: Int16
  @NSManaged public var songID: String
  @NSManaged public var artworkAsData: Data?
  @NSManaged public var stack: TopTracksStack
  @NSManaged public var songAsData: Data?
}


extension TopTracksSong : Identifiable {
}

extension TopTracksSong {
  var currentStackPosition: Int {
    get {
      Int(stackPosition)
    }
    set {
      stackPosition = Int16(newValue)
    }
  }
  
  var moveUpOrDown: Int {
    get {
      Int(upOrDown)
    }
    set {
      switch newValue {
      case 0: stackPosition = 0
      case ...0: stackPosition -= 1
      case 0...: stackPosition += 1
      default: fatalError("An int cant not be 0, <0, or >0")
      }
    }
  }
  
  func moveUp() {
    upOrDown += 1
  }
  func moveDown() {
    upOrDown -= 1
  }
}
import SwiftUI


extension TopTracksSong {
  var song: Song? {
    guard let data = songAsData else {return nil}
    return try? PropertyListDecoder().decode(Song.self, from: data)
  }
  
  var title: String {
    return song?.title ?? "Title unknown"
  }
  
  var artistName: String {
    return song?.artistName ?? "Artist unknown"
  }
  var url: URL? {
    return song?.url
  }
  var artwork: Artwork? {
    guard let data = artworkAsData else {return nil}
    return try? PropertyListDecoder().decode(Artwork.self, from: data)
  }
  
  var categoryColor: Color? {
    stack.rotationCategory.color
  }
}
