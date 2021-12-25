import SwiftUI

struct StationBuilderStage<A: View> {
  let directions: String
  let stage: A
}

extension StationBuilderStage {
  init(_ directions: String, stage: () -> A) {
    self.init(directions: directions,
              stage: stage())
  }
}

extension StationBuilderStage: View {
  var body: some View {
    VStack {
      Text(directions)
        .multilineTextAlignment(.center)
        .padding()
      stage
    }
  }
}

struct BuilderStage_Previews: PreviewProvider {
  static var previews: some View {
    StationBuilderStage(directions: "Do this",
                        stage: Text("experiment"))
  }
}

