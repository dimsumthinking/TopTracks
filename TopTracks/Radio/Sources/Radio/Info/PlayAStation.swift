import SwiftUI

struct PlayAStation {
}

extension PlayAStation: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("On your iPhone, iPad, or Mac:").underline()
      .padding(.vertical)
      
      Text("Tap a specific station in the station list to play a station. ")
       + Text("Tap the ") + Text("\(Image(systemName: "dice"))").foregroundStyle(Color.accentColor) + Text(" in the upper right corner to play a random station.")

      
      Text("If installed on the Watch:").underline()
            .padding(.vertical)
      
      Text("Make sure app is running on paired device.\n") +
      Text("Tap 'Play Random Station' to play a random station.") +
      Text("Tap a specific station in the station list to play a station.")
      
      Text("If a station doesn't play:").underline()
      .padding(.vertical)
      
      Text("Try it again. If it still doesn't work, ") +
      Text("you may need to remove the station and re-add it.")
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - Select a station")
  }
}
