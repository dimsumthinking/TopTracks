import SwiftUI
import Model

struct ClockInfo {
}

extension ClockInfo: View {
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Spacer()
        Text("Tap a station to enjoy a fresh music mix.")
        Spacer()
      }
      

        Text("The music begins at the top of this clock with a power song and then we move clockwise.")
        .multilineTextAlignment(.center)
      
      ClockView(hour: musicClock)
      
      Text("As we move around the clock, you'll hear a song in the highlighted category that played longest ago.")
      
      .multilineTextAlignment(.center)

   
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - Play a Station")
  }
}
