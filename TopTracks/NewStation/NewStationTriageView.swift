import SwiftUI
import MusicKit
import CoreData

struct NewStationTriageView {
//  let station: TopTracksStation
  let playlistID : String
  @State private var songRatings: [NewStationSongRating]
  @State private var showDeleteAlert = false
  
  init(playlistID: String, songs: [Song]) {
    self.playlistID = playlistID
    self.songRatings = songs.map{NewStationSongRating.init(song: $0, rating: 0)}
//    let request: NSFetchRequest<TopTracksStation> = TopTracksStation.fetchRequest()
//    request.sortDescriptors = [NSSortDescriptor(key: "lastUpdated", ascending: false)]
//    request.predicate = NSPredicate(format: "%K == %@", #keyPath(TopTracksStation.playlistID), playlistID)
//    do {
//      let results = try viewContext.fetch(request)
//      guard let station = results.first else {fatalError("Couldn't retrieve station")}
//      self.station = station
//    } catch {
//      print("error fetching station")
//      self.station = TopTracksStation(context: viewContext)
//    }
  }
}

extension NewStationTriageView: View {
  var body: some View {
    VStack {
      InstructionView("Your Top Tracks station needs at least 40 songs with ratings over 0. \n Currently there are \(numberOver0).")
      List($songRatings) {$songRating in
        NewStationSongRatingView(song: songRating.song,
                                 rating: $songRating.rating)
          .listRowSeparatorTint(.indigo)
      }
      HStack {
        Button("Delete the station",
               role: .destructive,
               action: {showDeleteAlert = true})
        Spacer()
        Button("Create the station", action: createTheStation)
          .disabled(notEnoughSongs)
      }
      .buttonStyle(.borderedProminent)
      .padding()
    }
    .onDisappear {
      AppleMusicPlaylistSongPreviewView.audioPlayer = nil
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Sort top to bottom",
               action: sortTheSongs)
          .disabled(nothingToSort)
      }
    }
    .alert("Delete station and lose all work?",
           isPresented: $showDeleteAlert) {
      Button("Yes, delete the station",
             role: .destructive,
             action: deleteTheStation)
      Button("Cancel",
             role: .cancel,
             action: {showDeleteAlert = false})
    }
    .navigationBarBackButtonHidden(true)
  }
}

extension NewStationTriageView {
  private var numberOver0: Int {
    songRatings.filter{$0.rating > 0}.count
  }
  private var notEnoughSongs: Bool {
    numberOver0 < 40
  }
  private var nothingToSort: Bool {
    numberOver0 == 0
  }
  
}

extension NewStationTriageView {
  private func sortTheSongs() {
    self.songRatings = songRatings.sorted{$0.rating > $1.rating}
  }
  private func deleteTheStation() {
//    viewContext.delete(station)
//    do {
//      try viewContext.save()
//    } catch {
//      viewContext.rollback()
//      print("Couldn't delete station")
//    }
  }
  private func createTheStation() {
    
  }
}
