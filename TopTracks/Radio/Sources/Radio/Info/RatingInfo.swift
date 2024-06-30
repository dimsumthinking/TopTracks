import SwiftUI
import Model

struct RatingInfo: View {
  
}

extension RatingInfo {
  var body: some View {
    
    VStack(alignment: .leading) {
      HStack {
        Spacer()
        Text("Rate the songs. \(Image(systemName: "wand.and.stars")) \(Image(systemName: "star"))")
        Spacer()
      }
      .padding()
      .padding(.vertical)
      
      ForEach(SongRating.allCases,
           id: \.self) {rating in
        Text("\(Image(systemName: rating.icon)) \(rating.name)")
      }
           .padding()
      
      VStack(alignment: .leading) {
        Text(" \(Image(systemName: "wand.and.stars")) Not available for Top 25 and Top 100 charts.").padding(.bottom)
        Text(" \(Image(systemName: "star")) This rating influences whether you hear this song more or less the next time you rotate the music in your station.").padding(.bottom)
      }
      .font(.caption)
      .foregroundColor(.secondary)
      .padding(.horizontal)
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - Song Ratings")
  }
}
