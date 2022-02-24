import SwiftUI

struct ClockLegendView {
  let categories: [RotationCategory]
}

extension ClockLegendView: View {
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(categories) {category in
        HStack {
          category.symbol
          Text(category.description)
        }.padding(2)
      }
    }
  }
}

struct ClockLegendView_Previews: PreviewProvider {
  static var previews: some View {
    ClockLegendView(categories: standardCategories)
  }
}
