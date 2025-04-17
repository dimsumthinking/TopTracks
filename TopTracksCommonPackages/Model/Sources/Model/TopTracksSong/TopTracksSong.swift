import Foundation
import SwiftData
import MusicKit

@Model public class TopTracksSong {
    var songAsData: Data?
    var songID: String?
    
    var artistName: String = "Artist Name"
    public var id: UUID = UUID()
    public var lastPlayed: Date = Date()
    public var motion: String = "added"
    public var rating: String = SongRating.neutral.description
    public var title: String = "Song Title"
    
    public var stack: TopTracksStack?
  
  public init(song: Song) {
      self.songID = song.id.rawValue
      self.songAsData = try? JSONEncoder().encode(song)
      
      self.artistName = song.artistName
      self.title = song.title
  }
}

extension TopTracksSong {
  public var song: Song? {
    guard let data = songAsData else {return nil}
    if let decodedSong =  try? JSONDecoder().decode(Song.self, from: data) {
      return decodedSong
    } else {
      return try? PropertyListDecoder().decode(Song.self, from: data)
    }
  }
  
  
  public var songRating: SongRating {
    get {
      SongRating(rawValue: rating) ?? .neutral
    }
    set {
      rating = newValue.rawValue
    }
  }
  
  public var songMotion: SongMotion {
    SongMotion(rawValue: rating) ?? .same
  }
  
  public var station: TopTracksStation? {
    stack?.station
  }
    
    public var rotationCategory: RotationCategory {
      get {
        stack?.rotationCategory ?? .power
      } set {
        do {
          if rotationCategory == .archived || rotationCategory == .removed {
            createStack(for: rotationCategory)
          }
          try changeStack(to: newValue)
        } catch {
          StationUpdatersLogger.rotatingStation.info("Couldn't change  song's category to \(newValue)")
        }
      }
    }
  
  public func changeStack(to rotationCategory: RotationCategory) throws {
    
    if let station = station,
      let newStack = station.stacks?.first(where: {$0.rotationCategory == rotationCategory}) {
      self.motion = motionMoving(from: self.rotationCategory,
                                 to: rotationCategory,
                                 given: songMotion).name
      self.stack = newStack
      try station.modelContext?.save()
      StationUpdatersLogger.rotatingStation.info("Changed  song's category to \(rotationCategory)")
    } else {
      StationUpdatersLogger.rotatingStation.info("Couldn't change  song's category to \(rotationCategory)")  
    }
  }
  
  private func createStack(for rotationCategory: RotationCategory)  {
    guard let station = station,
          let stacks = station.stacks,
          let context = station.modelContext,
          stacks.filter({$0.rotationCategory == rotationCategory}).isEmpty else {
            StationUpdatersLogger.rotatingStation.info(" \(rotationCategory) already exists")
            return
          }
    let newStack = TopTracksStack(category: rotationCategory)
    context.insert(newStack)
    newStack.station = station
    do {
      try context.save()
      StationUpdatersLogger.rotatingStation.info("Created category  \(rotationCategory)")
    } catch {
      StationUpdatersLogger.rotatingStation.info("Couldn't create \(rotationCategory)")
    }
    
  }
}

