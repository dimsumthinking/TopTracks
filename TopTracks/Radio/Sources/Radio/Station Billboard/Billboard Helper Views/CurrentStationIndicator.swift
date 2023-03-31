import SwiftUI

struct CurrentStationIndicator {
}

extension CurrentStationIndicator: View {
  var body: some View {
    HStack {
      Spacer()
      
      Image(systemName: "antenna.radiowaves.left.and.right")
        .padding(.trailing)
        .font(.largeTitle)
        .foregroundColor(.yellow)
    }
  }
}
