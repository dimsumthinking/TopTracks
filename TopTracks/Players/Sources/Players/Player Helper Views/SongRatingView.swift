import SwiftUI
import ApplicationState
import Model


struct SongRatingView: View {
  @State private var isShowingAlert = false
}

extension SongRatingView {
  var body: some View {
    Menu {
      Text("Song Rating:")
      ForEach(SongRating.allCases, id: \.self) { rating in
        RatingButton(rating: rating,
                     isShowingAlert: $isShowingAlert,
                     action: updateSong)
      }
    } label: {
      Image(systemName: CurrentSong.shared.ratingIconName)
    }

    .alert("Remove " + (CurrentSong.shared.nowPlaying?.song?.title ?? "this song") + "?",
           isPresented: $isShowingAlert) {
      Button(role: .destructive) {
        do {
          try removeCurrentSong()
        } catch {
          PlayersLogger.removingSong.info("Can't remove \(CurrentSong.shared.nowPlaying?.song?.title ?? "song")")
        }
      } label: {
        Text("Permanently remove from this station")
      }
      
      Button(role: .cancel) {
        isShowingAlert = false
      } label: {
        Text("Cancel")
      }
      
      
    } message: {
      Text("This action cannot be undone")
    }
    
  }
}

extension SongRatingView {
  private func updateSong(rating: SongRating)  {
    do {
      try CurrentSong.shared.changeRating(to: rating)
    } catch {
      PlayersLogger.updatingSong.info("Can't update song")
    }
  }
  private func removeCurrentSong() throws {
    try CurrentSong.shared.removeCurrentSong()
  }
}

