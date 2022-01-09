import CoreData
import MusicKit

extension TopTracksStation {
  convenience init(stationName: String,
                   playlistID: String,
                   buttonPosition: Int,
                   songsAndRatings: [NewStationSongRating],
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.lastUpdated = Date()
    self.updateAvailable = false
    self.playlistID = playlistID
    self.stationName = stationName
    self.stationID = UUID()
    self.clockPosition = 0
    self.favorite = false
    self.currentSong = nil
    self.isPlaying = false
    self.stacks = topTracksStacks(from: songsAndRatings, context: context)
    //self.clock is set in stacks(from:) below
  }
}

extension TopTracksStation {
  
  private func topTracksStacks(from songsAndRatings: [NewStationSongRating],
                               context: NSManagedObjectContext) -> Set<TopTracksStack> {
    let selectedSongs = selectedSongs(from: songsAndRatings)
    var topTracksStacks = Set<TopTracksStack>()
    for stack in stacks(from: selectedSongs) {
      topTracksStacks.insert(TopTracksStack(rotationCategory: stack.rotationCategory,
                                   songs: stack.songs,
                                   station: self,
                                   context: context))
    }
    return topTracksStacks
  }
  
  private func selectedSongs(from songsAndRatings: [NewStationSongRating]) -> [Song] {
     songsAndRatings
      .filter{item in item.rating > 0}
      .sorted{item1, item2 in item1.rating > item2.rating}
      .map(\.song)
  }
  
  
  private func stacks(from songs: [Song]) -> [(rotationCategory: RotationCategory,
                                               songs: [Song])]{
    
    if songs.count < 36 {
      self.clock = "shortHour"
      let n = Int(songs.count / 3)
      return [(RotationCategory.power, Array(songs[..<n])),
              (.current, Array(songs[n..<2*n])),
              (.added, Array(songs[(2*n)...])),
              (.gold, Array<Song>())]
    } else {
      self.clock = "defaultHour"
      let n = min(Int(songs.count / 4), preferredMaximumSongsPerPlaylist)
      return [(RotationCategory.power, Array(songs[..<n])),
              (.current, Array(songs[n..<2*n])),
              (.added, Array(songs[2*n..<3*n])),
              (.gold, Array(songs[(3*n)...]))]
    }
  }
}
