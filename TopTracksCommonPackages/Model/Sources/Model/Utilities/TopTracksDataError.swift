public enum TopTracksDataError: Error {
  case couldNotCreateStationOnBackgroundContext
  case couldNotChangeOrderOfStations
  case couldNotGetStacksForStation
  case stationMissingStandardRotationCategory
  case stationMissingAddedCategory
  case stationMissingGoldOrArchived
}