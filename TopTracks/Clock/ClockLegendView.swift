import SwiftUI

struct ClockLegendView: View {
  var body: some View {
    VStack {
      ForEach(RotationCategory.allCases) {category in
        Text(category.description)
          .foregroundColor(category.color)
      }
    }
  }
}

struct ClockLegendView_Previews: PreviewProvider {
  static var previews: some View {
    ClockLegendView()
  }
}
