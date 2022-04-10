//import MusicKit
//import AudioToolbox
//
//func musicQueue(for station: TopTracksStation) -> ApplicationMusicPlayer.Queue {
//  let selector = SongSelector(station: station,
//                              clock: station.clock!)
//  selector.fillSongList()
//  return ApplicationMusicPlayer.Queue(for: selector.songList)
//}
//
//class SongSelector {
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
//extension SongSelector {
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
