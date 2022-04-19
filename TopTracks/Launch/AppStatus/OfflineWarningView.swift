import SwiftUI

struct OfflineWarningView {
  
}

extension OfflineWarningView: View {
  var body: some View {
    HStack {
      Image(systemName: "exclamationmark.triangle")
        .font(.largeTitle)
        .foregroundColor(.orange)
        .padding(.trailing)
      VStack (alignment: .center){
        Text("You're offline")
        Text("Check your network settings")
          .font(.caption)
      }
      .padding(.horizontal)
    }
    .padding()
    .padding(.vertical)
  }
}

struct OfflineWarningView_Previews: PreviewProvider {
  static var previews: some View {
    OfflineWarningView()
  }
}
