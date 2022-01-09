import CoreData
import MusicKit

extension TopTracksStack {
  convenience init(rotationCategory: RotationCategory,
                   songs: [Song],
                   station: TopTracksStation,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.stackName = rotationCategory.description
    var topTracksSongs: [TopTracksSong] =  []
    for (index, song) in songs.enumerated() {
      topTracksSongs.append(TopTracksSong(song: song,
                                          stack: self,
                                          stackPosition: index,
                                          context: context))
    }
    self.songs = Set(topTracksSongs)
    self.station = station
  }
}
