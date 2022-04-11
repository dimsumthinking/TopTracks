import MusicKit
import AudioToolbox

let stationSongQueue = StationSongQueue()

class StationSongQueue {
  private var queue = ApplicationMusicPlayer.shared.queue
  private var stacks  = [RotationCategory: [Song]]()
  fileprivate init(){}
}

extension StationSongQueue {
  var info: String {
    queue.entries.count.description
  }
  func fillQueue(for station: TopTracksStation) -> [Song] {
    stacks = stacks(for: station)
    let songs = songList(for: station)
    stacks.removeAll()
    return songs
  }
  
  func refillQueue(for station: TopTracksStation,
                   startingWith currentSong: Song? = nil) -> [Song]  {
    stacks = stacks(for: station)
    let songs = songList(for: station, currentSong: currentSong)
    stacks.removeAll()
    return songs
  }
  
  private func songList(for station: TopTracksStation,
                        currentSong: Song? = nil) -> [Song] {
    var songs = [Song]()
    if let currentSong = currentSong {
      songs.append(currentSong)
    }
    let clock = station.clock ?? defaultRotationClock
    for index in 0...numberOfSongsInMusicQueue {
      let currentCategory = clock.slots[index % clock.numberOfSlots]
      if let song = nextSong(in: currentCategory) {
        songs.append(song)
      }
    }
    return songs
  }
  
  private func nextSong(in category: RotationCategory) -> Song? {
    guard var stack = stacks[category],
          stack.count > 2 else {return nil}
    let index = Int.random(in: 0...1)
    let song = stack.remove(at: index)
    stacks[category] = stack + [song]
    return song
  }
  
  private func stacks(for station: TopTracksStation) -> [RotationCategory: [Song]] {
    var stacks = [RotationCategory: [Song]]()
    standardRotationCategories.forEach{ category in
//      print(category)
      stacks[category] = initializeStack(in: station,
                                         category: category)
//      print(stacks[category]!.map(\.title))
    }
    return stacks
  }
  
  private func initializeStack(in station: TopTracksStation,
                                   category: RotationCategory) -> [Song] {
    station.stacks
      .filter{$0.stackName == category.rawValue}
      .flatMap(\.songs)
      .sorted{$0.stackPosition < $1.stackPosition}
      .compactMap(\.song)
  //    .compactMap(PlayableSong.init(topTracksSong:))
  }
  
//    private var currentSong: Song? {
//      guard let item =  queue.currentEntry?.item else {return nil}
//      switch item {
//      case .song(let innerSong):
//        if let station = station {
//        station.markAsPlayed(songID: innerSong.id.rawValue)
//        }
//        return innerSong
//      default:
//        return nil
//      }
//    }

}



//import MusicKit
//import AudioToolbox
//
//func musicQ(for station: TopTracksStation) -> ApplicationMusicPlayer.Queue {
//  let selector = StationSongPlayer(station: station,
//                              clock: station.clock)
//  selector.fillSongList()
//  return ApplicationMusicPlayer.Queue(for: selector.songList)
//}
//
//class StationSongPlayer {
//  let station: TopTracksStation
//  let clock: RotationClock
//  var songList = [Song]()
//  var stacks = [RotationCategory: [Song]]()
//
//  init(station: TopTracksStation,
//       clock: RotationClock) {
//    self.station = station
//    self.clock = clock
//    standardRotationCategories.forEach{ category in
//      stacks[category] = initializeStack(in: station,
//                                         category: category)
//    }
//  }
//}
//
//
//fileprivate func initializeStack(in station: TopTracksStation,
//                                 category: RotationCategory) -> [Song] {
//  station.stacks
//    .filter{$0.stackName == category.rawValue}
//    .flatMap(\.songs)
//    .sorted{$0.stackPosition < $1.stackPosition}
//    .compactMap(\.song)
////    .compactMap(PlayableSong.init(topTracksSong:))
//}
//
//
//extension StationSongPlayer {
//  fileprivate func fillSongList() {
//    for index in 0...numberOfSongsInMusicQueue {
//      let currentCategory = clock.slots[index % clock.numberOfSlots]
//      if let song = nextSong(in: currentCategory) {
//        songList.append(song)
//      }
//    }
//  }
//  
//  private func nextSong(in category: RotationCategory) -> Song? {
//    guard var stack = stacks[category],
//          stack.count > 2 else {return nil}
//    let index = Int.random(in: 0...1)
//    let song = stack.remove(at: index)
//    stacks[category] = stack + [song]
//    return song
//  }
//}
//
