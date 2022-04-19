import SwiftUI

struct DataWarningView {
  
}

extension DataWarningView: View {
  var body: some View {
    HStack {
      Image(systemName: "wifi.exclamationmark")
        .font(.largeTitle)
        .foregroundColor(.yellow)
        .padding(.trailing)
      VStack {
        Text("You're not on wifi. \nTap if you don't want to use Cellular Data.")
          .multilineTextAlignment(.center)
      }
      .padding(.horizontal)
    }
    .padding()
    .padding(.vertical)
    .contentShape(Rectangle())
    .onTapGesture {
      goToSettings()
    }
  }
  
  
  private func goToSettings() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
  }
}

struct DataWarningView_Previews: PreviewProvider {
  static var previews: some View {
    DataWarningView()
  }
}
