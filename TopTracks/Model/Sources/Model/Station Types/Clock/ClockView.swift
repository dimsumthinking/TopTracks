import SwiftUI

public struct ClockView {
  let hour: [RotationCategory]
  public init(hour: [RotationCategory]) {
    self.hour = hour
  }
}

extension ClockView: View {
  public var body: some View {
    ZStack {
      ForEach(0..<hour.count,
              id: \.self) {index in
        ClockSegmentView(segmentNumber: index,
                         numberOfSegments: hour.count,
                         category: hour[index])
        
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
    ClockView(hour: musicClock)
    
    
  }
}
