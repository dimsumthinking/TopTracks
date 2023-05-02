import SwiftUI
import Model

struct PlayAStation {
}

extension PlayAStation: View {
  var body: some View {
    VStack {
      VStack (alignment: .leading, spacing: 20) {
        
        Text("The player displays the essential song information.")
        Text("Use it to play, pause or skip to the next song.")
        Text("Jump ahead or back within a song.")
        Text("Rate the songs to influence how often a song is played \(Image(systemName: "star"))\(Image(systemName: "wand.and.stars"))")
        
      }
      .font(.headline)
      .padding()
      VStack(alignment: .leading) {
        Text("\(Image(systemName: "star")) Ratings are used next time you rotate the station's music.")
          .padding([.top])
        
        Text("\(Image(systemName: "wand.and.stars"))  Not available in Top 25 & Top 100 Charts. \n \t \t They update automatically.")
          .padding([.vertical])
      }
      .foregroundColor(.secondary)
      .font(.caption)
    }
    .padding()
    .navigationTitle("Info - The Player")
  }
}
