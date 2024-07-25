import MusicKit
import Model
import Foundation
import Constants

class StationChangeCache {
  private(set) var currentSong: TopTracksSong?
  private(set) var currentStation: TopTracksStation?
  private(set) var currentTime: TimeInterval
  
  
  
  
  init(currentSong: TopTracksSong?,
       currentStation: TopTracksStation?,
       currentTime: TimeInterval = 0) {
    self.currentSong = currentSong
    self.currentStation = currentStation
    self.currentTime = currentTime
    
  }
  
}
