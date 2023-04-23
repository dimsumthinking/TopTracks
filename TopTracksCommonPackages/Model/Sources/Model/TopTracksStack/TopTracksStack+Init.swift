import CoreData
import MusicKit

extension TopTracksStack {
  convenience init(category: RotationCategory,
                   songs: [Song],
                   station: TopTracksStation,
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.name = category.name
    self.station = station
    self.songs = topTrackSongs(songs: songs,
                               context: context)
    print(name, ":  \n", songs.map(\.title))
  }
}

extension TopTracksStack {
  private func topTrackSongs(songs: [Song],
                             context: NSManagedObjectContext) -> Set<TopTracksSong> {
    var topTracksSongs = Set<TopTracksSong>()
    for song in songs {
      topTracksSongs.insert(TopTracksSong(song: song,
                                          stack: self,
                                          context: context))
    }
    return topTracksSongs
  }
}
