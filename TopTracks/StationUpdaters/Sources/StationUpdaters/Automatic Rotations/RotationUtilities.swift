import Model

func orderedSongs(_ topTracksSongs: [TopTracksSong]) -> [TopTracksSong] {
  topTracksSongs
    .sorted { $0.songRating  < $1.songRating }
    .sorted { $0.songMotion  < $1.songMotion }
    .sorted { $0.songRating  < $1.songRating }
}

func markRemainingSame(_ topTracksSongs: [TopTracksSong]) {
  for song in topTracksSongs {
    song.motion = "same"
  }
}
