import SwiftUI

struct ClockSegmentView {
  let segmentNumber: Double
  let numberOfSegments: Double
  let category: RotationCategory
}

extension ClockSegmentView: View {
  var body: some View {
    GeometryReader {proxy in
      let lineWidth = lineWidth(for: proxy)
      ZStack {
      Circle()
        .trim(from: 0, to: 1 / numberOfSegments)
        .stroke(lineWidth: lineWidth)
        .padding(lineWidth/2)
        .rotationEffect(rotation)
        .foregroundColor(category.color)
        category.symbol
          .foregroundColor(.black)
          .font(.body.bold())
          .offset(x: 0, y: -lineWidth)
          .rotationEffect(labelRotation)
      }

    }
  }
}

extension ClockSegmentView {
  private func lineWidth(for proxy: GeometryProxy) -> Double {
    let size = proxy.frame(in: .local).size
    return min(size.height, size.width)/3
  }
  
  private var rotation: Angle {
    .radians(2 * Double.pi *  ((segmentNumber  - 1/2 ) / numberOfSegments - 1/4) )
  }
  private var labelRotation: Angle {
    .radians(2 * Double.pi *  ((segmentNumber   ) / numberOfSegments ) )
  }
}

struct ClockSegmentView_Previews: PreviewProvider {
  static var previews: some View {
    ClockSegmentView(segmentNumber: 0, numberOfSegments: 15, category: .power)
  }
}
