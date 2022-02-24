import SwiftUI

struct CategoryRepeatView {
  let categories: [RotationCategory] = expandedCategories
  let repeatFrequencies: [String] = ["1-2 hours",
                                   "2-3 hours",
                                   "3-4 hours",
                                   "6+ hours"]
}

extension CategoryRepeatView: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Categories")
          .bold()
          .underline()
          .padding(.leading)
        Spacer()
        Text("Rotates every")
          .bold()
          .underline()
      }
      ForEach(categories.indices) {index in
        HStack {
          categories[index].symbol
          Text(categories[index].description)
          Spacer()
          Text(repeatFrequencies[index])
            .padding(.trailing)
        }.padding(2)
      }
    }
    .padding()
    .padding(.horizontal)
  }
}

struct CategoryRepeatView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryRepeatView()
  }
}
