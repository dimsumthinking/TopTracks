import SwiftUI
import ApplicationState
import Model


struct SongRatingView {
//  @EnvironmentObject private var applicationState: ApplicationState
  @State private var isShowingAlert = false
 @State private var updatedAt = Date()
}

extension SongRatingView: View {
  var body: some View {
    Menu {
      Text("Song Rating:")
      ForEach(SongRating.allCases, id: \.self) { rating in
        Button (role: rating == .remove ? .destructive : .none) {
          if rating == .remove {
            isShowingAlert = true
          } else {
            updateSong(rating: rating)
          }
        } label: {
          HStack {
            Image(systemName: rating.icon)
            Text(rating.name)
          }
        }
      }
    } label: {
      VStack {
        Image(systemName: CurrentSong.shared.ratingIconName)
        Text(updatedAt, style: .relative).foregroundColor(.clear)
          .font(.caption2)
      }
    }
    .alert("Remove " + (CurrentSong.shared.song?.title ?? "this song") + "?",
           isPresented: $isShowingAlert) {
      Button(role: .destructive) {
        do {
          try removeCurrentSong()
        } catch {
          PlayersLogger.removingSong.info("Can't remove \(CurrentSong.shared.song?.title ?? "song")")
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
