import SwiftUI
import Model

struct InfoView: View {
}

extension InfoView  {
  var body: some View {
      Section("Station Info") {
        Text("Long press a station to edit it. Tap a station to play it.")
          .multilineTextAlignment(.center)
        
        ClockView(hour: musicClock)
        
        Text("Play begins at the top of the clock with a power song. As we move around the clock, you'll hear a song in that category that played longest ago.")
          .multilineTextAlignment(.center)
        
      }
    
  }
}
