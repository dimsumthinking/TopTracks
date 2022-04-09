import SwiftUI

struct CategoryRepeatView {
  let categories: [RotationCategory] = standardRotationCategories
//  let repeatFrequencies: [String] = ["1-2 hours",
//                                   "2-3 hours",
//                                   "3-4 hours",
//                                   "6+ hours"]
}

extension CategoryRepeatView: View {
  var body: some View {
    VStack {//}(alignment: .leading) {
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
      ForEach(categories) {category in
        HStack {
          category.symbol
          Text(category.description)
          Spacer()
          Text(category.repeatFrequency)
            .padding(.trailing)
        }.padding(2)
      }
//      ForEach(categories.indices) {index in
//        HStack {
//          categories[index].symbol
//          Text(categories[index].description)
//          Spacer()
//          Text(repeatFrequencies[index])
//            .padding(.trailing)
//        }.padding(2)
//      }
    }
    .padding()
    .padding(.horizontal)
  }
}

extension RotationCategory {
  fileprivate var repeatFrequency: String {
    switch self {
    case .power:
      return "1-2 hours"
    case .current:
      return "2-3 hours"
    case .added:
      return "3-4 hours"
    default:
      return "6+ hours"
    }
  }
}

struct CategoryRepeatView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryRepeatView()
  }
}
