import SwiftUI

struct WorkWithStations {
}

extension WorkWithStations: View {
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Spacer()
        Text("Here's a list of station actions")
        Spacer()
      }

        Text("Swipe left on a station")
          .underline()
      .padding()
      HStack {
        Image(systemName: "trash")
          .foregroundColor(.red)
        Text("Delete the station")
      }
      HStack {
        Image(systemName: "text.line.first.and.arrowtriangle.forward")
          .foregroundColor(.indigo)
        Text("Move the station to the top of the list")
      }
      HStack {
        Image(systemName: "square.and.arrow.up.fill")
          .foregroundColor(.blue)
        Text("Share the station")
      }
        Text("Swipe right on a station")
          .underline()
          .padding()
      HStack {
        Image(systemName: "music.note.list")
          .foregroundColor(.orange)
        Text("View the active songs")
      }
      HStack {
        Image(systemName: "arrow.triangle.2.circlepath.circle")
          .foregroundColor(.cyan)
        Text("Rotate the active songs \(Image(systemName: "star")) \(Image(systemName: "wand.and.stars"))")
      }
      HStack {
        Image(systemName: "goforward.plus")
          .foregroundColor(.mint)
        Text("Add to and rotate songs \(Image(systemName: "star"))  \(Image(systemName: "wand.and.stars")) \(Image(systemName: "star.fill"))")
      }
      VStack(alignment: .leading) {
        Text("\(Image(systemName: "star")) Rotation is based on your song ratings.")
          .padding([.top])
        
        Text("\(Image(systemName: "wand.and.stars")) Top 25 & Top 100 Charts update automatically daily.")
          .padding([.vertical])
        Text("\(Image(systemName: "star.fill")) Only when new songs are available to be added.")
          .padding(.bottom)
      }
      .foregroundColor(.secondary)
      .font(.caption)
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - Make Adjustments")
  }
}
