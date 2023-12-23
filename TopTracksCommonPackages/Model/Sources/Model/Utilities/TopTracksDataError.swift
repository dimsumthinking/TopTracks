public enum TopTracksDataError: Error {
  case couldNotCreateStationOnBackgroundContext
  case couldNotCreateSongOnBackgroundContext
  case couldNotChangeOrderOfStations
  case couldNotGetStacksForStation
  case stationMissingStandardRotationCategory
  case stationMissingAddedCategory
  case stationMissingGoldOrArchived
  case couldNotUpdateArtwork
}
