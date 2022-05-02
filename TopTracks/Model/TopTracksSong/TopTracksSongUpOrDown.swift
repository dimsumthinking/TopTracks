import MusicKit
import CoreData

extension TopTracksSong {
  func adjustFrequencyChange(_ newSetting: UpdateFrequencyChange) {
    upOrDown = Int16(newSetting.rawValue)
   try? managedObjectContext?.save()
  }
}
