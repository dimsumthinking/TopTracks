import CoreData

extension TopTracksClock {
  convenience init(rotationClock: RotationClock,
                   station: TopTracksStation,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.clockPosition = 0
    self.clockAsData = try? PropertyListEncoder().encode(rotationClock)
    self.station = station
  }
}
