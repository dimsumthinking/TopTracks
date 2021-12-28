import SwiftUI

struct InstructionView {
  let instructions: String
  
  init(_ instructions: String) {
    self.instructions = instructions
  }
}

extension InstructionView: View {
  var body: some View {
    Text(instructions)
      .font(.callout)
      .foregroundColor(.secondary)
      .multilineTextAlignment(.center)
      .padding()
  }
}

struct InstructionView_Previews: PreviewProvider {
  static var previews: some View {
    InstructionView("Some instructions for building a station.\n First do this.")
  }
}
