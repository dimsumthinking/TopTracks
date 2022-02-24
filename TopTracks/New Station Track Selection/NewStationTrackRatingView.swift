import SwiftUI

struct NewStationTrackRatingView {
  @Binding var songAndRating: NewStationSongRating
  @State private var rating = 0
}

extension NewStationTrackRatingView: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          
          Text(songAndRating.song.title)
          Text(songAndRating.song.artistName)
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Spacer()
        if songAndRating.rotationCategory != .notIncluded {
          songAndRating.rotationCategory.symbol
//            .font(.title)
//            .foregroundColor(.secondary)
        }
      }
      Picker("Choose", selection: $rating){
        ForEach(0..<4) {index in
          switch index {
          case 0:
            Image(systemName: "clear")
          default:
            standardCategories[3 - index].symbol
          }
        }
      }
      .pickerStyle(.segmented)
    }
    .onChange(of: rating){rating in
      switch rating {
      case 0:
        songAndRating.rotationCategory = .notIncluded
      default:
        songAndRating.rotationCategory = standardCategories[3 - rating]
      }
    }
  }
}


//Picker("Choose", selection: $songAndRating.rating){
//  ForEach(0..<6) {index in
//    switch index {
//    case 0:
//      Image(systemName: "clear")
//    default:
//      Image(systemName: index <= songAndRating.rating ? "star.fill" : "star")
//    }
//  }
//}
//.pickerStyle(.segmented)
//}
