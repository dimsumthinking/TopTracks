import SwiftUI

struct ClockView {
  let hour: Hour
}

extension ClockView: View {
  var body: some View {
    ZStack {
      ForEach(0..<hour.numberOfSlots) {index in
        ClockSegmentView(segmentNumber: Double(index),
                         numberOfSegments: Double(hour.numberOfSlots),
                         category: hour.categoryFor(slot: index))

      }
      .aspectRatio(1.0, contentMode: .fit)
      .padding()
      Circle()
        .scale(0.33)
        .foregroundColor(.black)
    }
    .aspectRatio(1.0, contentMode: .fit)
  }
}

struct ClockView_Previews: PreviewProvider {
  static var previews: some View {
    ClockView(hour: Hour(with: .hourWithSpice))
    
    
  }
}
