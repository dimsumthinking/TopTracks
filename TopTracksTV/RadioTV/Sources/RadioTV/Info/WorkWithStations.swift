import SwiftUI
import Model

struct WorkWithStations: View {
}

extension WorkWithStations {
  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 20) {
        
        Text("\(Image(systemName: "radio.fill")) \t Show the player.")
        Text("\(Image(systemName: "arrow.up.arrow.down")) \t Move the station up or down the list.")
        Text("\(Image(systemName:"play.fill")) \t Play the station.")
        Text("\(Image(systemName:"pause.fill")) \t Pause the station.")
        Text("\(Image(systemName: "ellipsis")) \t Delete the station.")
        Text("\t \t View the station playlist.")
        Text("\t \t Rotate the music \(Image(systemName:"star"))")
        Text("\t \t Add new music \(Image(systemName:"star"))")
      }
      .padding()
      .font(.headline)
      
      VStack(alignment: .leading) {
        Text("\(Image(systemName: "star")) If available.")
          .padding([.vertical])
      }
      .foregroundColor(.secondary)
      .font(.caption)
      
    }
    
    .navigationTitle("Info - Make Adjustments")
  }
}
