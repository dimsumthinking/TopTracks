import SwiftUI
import CoreData
import MusicKit

struct StationCreationView {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject var stationConstructionStatus: StationContructionStatus
  let playlist: Playlist
  let existingPlaylistsWithName: NSFetchRequest<TopTracksStation>
  @State private var creatingStation = false
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition", ascending: true)])
  var stations: FetchedResults<TopTracksStation>
  
  init(playlist: Playlist) {
    self.playlist = playlist
    let request: NSFetchRequest<TopTracksStation> = TopTracksStation.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "stationName", ascending: true)]
    request.predicate = NSPredicate(format: "%K contains %@", #keyPath(TopTracksStation.stationName), playlist.name)
    existingPlaylistsWithName = request
  }
}

extension StationCreationView: View {
  var body: some View {
    VStack {
      InstructionView("Do you want to create a station from this playlist?")
      HStack(spacing: 20) {
        Button("Yes, create a new station",
               action: addStation)
        NavigationLink(destination: Text(playlist.name), isActive: $creatingStation) {
          EmptyView()
        }
        Button("Cancel",
               role: .cancel,
               action: cancelStationConstruction)
      }
      AppleMusicPlaylistTracksPreviewView(playlist: playlist)
    }
    .navigationTitle(playlist.name)
  }
}

extension StationCreationView {
  private func addStation() {
    guard let results = try? viewContext.fetch(existingPlaylistsWithName) else {
      fatalError("Unable to search stations for \(playlist.name)")
    }
    let newStation = TopTracksStation(context: viewContext)
    newStation.stationName = stationName(for: results.count)
    newStation.buttonPosition = (stations.last?.buttonPosition ?? 0) + 1
    newStation.lastUpdated = Date()
    do {
      try viewContext.save()
    } catch {
      fatalError("Failed to save new station")
    }
    renumberButtons()
    creatingStation = true
  }
  
  
  private func stationName(for count: Int) -> String {
    guard count > 0 else {return playlist.name}
    return playlist.name + " \(count + 1)"
  }
  
  private func renumberButtons() {
    for (index, station) in stations.enumerated() {
      station.buttonPosition = Int16(index + 1)
      do {
        try viewContext.save()
      } catch {
        fatalError("Couldn't renumber button positions")
      }
    }
  }
  
  private func cancelStationConstruction() {
    AppleMusicPlaylistSongPreviewView.audioPlayer = nil
    stationConstructionStatus.isCreatingNew = false
  }
}


//
//struct StationCreationView_Previews: PreviewProvider {
//  static var previews: some View {
//    StationCreationView(playlist: Playlist(from: Decoder()) )
//  }
//}
