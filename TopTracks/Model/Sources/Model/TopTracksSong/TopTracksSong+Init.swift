import CoreData
import MusicKit

extension TopTracksSong {
  convenience init(song: Song,
                   stack: TopTracksStack,
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.songID = song.id.rawValue
    self.lastPlayed = Date()
    self.rating = SongRating.neutral.rawValue
    self.motion = "added"
    self.stack = stack
    self.title = song.title
    self.artistName = song.artistName
    self.songAsData = try? PropertyListEncoder().encode(song)
    self.id = UUID()
  }
}
