import SwiftUI


struct ArtworkFiller: View {
  let size: Double
}

extension ArtworkFiller {
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
