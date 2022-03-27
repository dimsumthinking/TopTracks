import SwiftUI
import MusicKit
import CoreData

struct StationCreationView {
  let results: [MusicTestResult]
  let playlist: Playlist
  let clock: RotationClock
  
    @FetchRequest(entity: TopTracksStation.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                     ascending: true)]) private var stations: FetchedResults<TopTracksStation>
    @EnvironmentObject private var topTracksStatus: TopTracksStatus
  
  init(songs: MusicTestSongs,
       spice: Bool) {
    let categories = spice ? expandedCategories : standardCategories
    self.results = songs.songs(categories: categories)
    self.playlist = songs.playlist
    self.clock = spice ? .hourWithSpice : .standardHour
  }
}

extension StationCreationView: View {
  var body: some View {
    VStack {
      Text("Congratulations! Here's the station you built")
      List {
        ForEach(results.sorted{$0.rotationCategory < $1.rotationCategory}) {result in
          HStack {
            VStack(alignment: .leading) {
              Text(result.song.title).bold()
              Text(result.song.artistName)
            }
            Spacer()
            result.rotationCategory.symbol
              .font(.largeTitle)
              .padding()
          }
          .foregroundColor(result.rotationCategory.color)
        }
      }
      Button(action: createStation){
        Text("Save your new station")
          .padding()
          .padding(.horizontal)
      }
      .padding(30)
      .buttonStyle(.borderedProminent)
      .padding()
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(playlist.name)
    .modifier(StationBuildCancellation())
  }
}

extension StationCreationView {
  func createStation() {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(stationName: playlist.name + decorationForStationName,
                             playlist: playlist,
                             buttonPosition: stations.count,
                             songsAndCategories: results,
                             clock: self.clock,
                             context: context)
    do {
      topTracksStatus.isCreatingNew = false
      try context.save()
      print("tried to save \(playlist.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
  
  private var decorationForStationName: String {
    let numberWithSameStart = stations.map(\.stationName)
      .filter{name in name.starts(with: playlist.name)}.count
    
    return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
  }
}
