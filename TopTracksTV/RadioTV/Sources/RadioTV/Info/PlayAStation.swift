import SwiftUI
import Model

struct PlayAStation {
}

extension PlayAStation: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Spacer()
        Text("Choose your music player")
        Spacer()
      }
      .padding(.vertical)
      .padding(.vertical)
      VStack(alignment: .leading, spacing: 20) {
        
        Text("The ") + Text("mini player").underline() + Text(" displays the essential song information.")
        Text("Use it to play, pause or skip to the next song.")
        Text("Swipe up to use the full player.")
      }
      .padding(.bottom)
      .padding(.bottom)

      VStack(alignment: .leading, spacing: 20) {
        Text("The ") + Text("full player").underline() + Text(" includes more options and information.")
        HStack {
          Image(systemName: "heart")
            .foregroundColor(.blue)
          Text("Rate the songs.")// to hear them more or less often.")
        }.padding(.leading)
        HStack {
          Image(systemName: "powersleep")
            .foregroundColor(.blue)
          Text("Set the sleep timer.")
        }.padding(.leading)
        
        Text("Swipe down to return to the station list and mini player")
      }
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - The Players")
  }
}
