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
                         color: hour.categoryFor(slot: index).color)
        
      }
    }.padding()
  }
}

extension RotationCategory {
  fileprivate var color: Color {
    switch self {
    case .power: return .red
    case .current: return .purple
    case .added: return .mint
    case .gold: return .yellow
    }
  }
}

struct ClockView_Previews: PreviewProvider {
  static var previews: some View {
    ClockView(hour: defaultHour).background(Color.cyan.opacity(0.1))
  }
}
