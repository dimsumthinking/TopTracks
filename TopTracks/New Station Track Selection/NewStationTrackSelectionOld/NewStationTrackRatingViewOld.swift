//import SwiftUI
//
//struct NewStationTrackRatingView {
//  @Binding var songAndRating: NewStationSongRating
//}
//
//extension NewStationTrackRatingView: View {
//  var body: some View {
//    VStack(alignment: .leading) {
//      HStack(alignment: .top) {
//        VStack(alignment: .leading) {
//          
//          Text(songAndRating.song.title)
//          Text(songAndRating.song.artistName)
//            .font(.caption)
//            .foregroundColor(.secondary)
//        }
//        Spacer()
//        if songAndRating.rotationCategory != .notIncluded {
//          songAndRating.rotationCategory.symbol
////            .font(.title)
////            .foregroundColor(.secondary)
//        }
//      }
//      Picker("Choose", selection: $songAndRating.rating){
//        ForEach(0..<6) {index in
//          switch index {
//          case 0:
//            Image(systemName: "clear")
//          default:
//            Image(systemName: index <= songAndRating.rating ? "star.fill" : "star")
//          }
//        }
//      }
//      .pickerStyle(.segmented)
//    }
//  }
//}
//
////extension NewStationTrackRatingView: View {
////  var body: some View {
////        VStack(alignment: .leading) {
////          Text(songAndRating.song.title)
////          Text(songAndRating.song.artistName)
////            .font(.caption)
////            .foregroundColor(.secondary)
////      Picker("Choose", selection: $songAndRating.rating){
////          ForEach(0..<6) {index in
////            switch index {
////            case 0:
////              Image(systemName: "clear")
////            default:
////              Image(systemName: index <= songAndRating.rating ? "star.fill" : "star")
////            }
////          }
////        }
////        .pickerStyle(.segmented)
////      }
////  }
////}
//
