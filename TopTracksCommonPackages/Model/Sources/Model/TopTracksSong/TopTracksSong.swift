import Foundation
import SwiftData
import MusicKit

@Model public class TopTracksSong {
    var songAsData: Data?
    var songID: String?
    
    var artistName: String = "Artist Name"
    public var id: UUID = UUID()
    var lastPlayed: Date = Date()
    var motion: String = "added"
    var rating: String = SongRating.neutral.description
    var title: String = "Song Title"
    
//    @Relationship(inverse: \TopTracksStack.songs) var stack: TopTracksStack
    var stack: TopTracksStack?
    
    init(song: Song,
         stack: TopTracksStack) {
        self.songID = song.id.rawValue
        self.songAsData = try? PropertyListEncoder().encode(song)
        
        self.artistName = song.artistName
        self.id = UUID()
        self.lastPlayed = Date()
        self.rating = SongRating.neutral.description
        self.motion = "added"
        self.title = song.title

        self.stack = stack
    }
}

extension TopTracksSong {
  public var song: Song? {
    guard let data = songAsData else {return nil}
    return try? PropertyListDecoder().decode(Song.self, from: data)
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

