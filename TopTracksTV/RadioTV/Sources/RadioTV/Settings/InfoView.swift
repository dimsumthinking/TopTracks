import SwiftUI
import Model

struct InfoView: View {
}

extension InfoView  {
  var body: some View {
      Section("Station Info") {
        HStack {
          VStack(alignment: .leading, spacing: 20) {
            Text("Long press a station to edit it.")
            Text("Tap a station to play it.")
            
            Text("Play begins at the top of the clock with a power song.")
            Text("As we move around the clock, you'll hear a song in that category that played longest ago.")
          }
          
          ClockView(hour: musicClock)
            .frame(maxWidth: 500, maxHeight: 500)
          

        }
        
      }
    
  }
}
