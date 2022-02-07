extension TopTracksStation {
  var nextHour: [TopTracksSong] {
    stacks.flatMap(\.songs)
  }
  
//  var nextSong: TopTracksSong {
//    
//  }
  
  
}
