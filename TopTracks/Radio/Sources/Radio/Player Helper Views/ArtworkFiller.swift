import SwiftUI


struct ArtworkFiller {
  let size: Double
}

extension ArtworkFiller: View {
  var body: some View {
    Image(systemName: "person.crop.square")
      .resizable()
      .frame(width: size,
             height: size)
      .foregroundColor(.clear)
      .background(Color.clear)
      .padding()
  }
}
