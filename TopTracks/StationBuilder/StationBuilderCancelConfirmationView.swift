import SwiftUI

struct StationBuilderCancelConfirmationView {
  @Binding var isCanceled: Bool
  @Binding var isBuilding: Bool
}

extension StationBuilderCancelConfirmationView: View {
  var body: some View {
    VStack(spacing: 50) {
      Text("Stop building this station?")
        .multilineTextAlignment(.center)
        .font(.title)
      Button("No, keep building",
             role: .cancel,
             action: {isCanceled = false})
      Button("Yes, cancel building and\n delete all of the work",
             role: .destructive,
             action: {isBuilding = false})
    }
    .padding(.horizontal, 30)
  }
}

struct StationBuilderCancelConfirmationView_Previews: PreviewProvider {
  static var previews: some View {
    StationBuilderCancelConfirmationView(isCanceled: .constant(true), isBuilding: .constant(true))
  }
}
