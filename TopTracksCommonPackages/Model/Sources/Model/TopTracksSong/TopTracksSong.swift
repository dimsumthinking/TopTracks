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
    var title: String = "Song Title"
    
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
        stack?.rotationCategory ?? .power
    }
}

