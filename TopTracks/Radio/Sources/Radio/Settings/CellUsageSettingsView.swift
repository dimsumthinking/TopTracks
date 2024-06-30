import SwiftUI

struct CellUsageSettingsView: View {
  
}

extension CellUsageSettingsView {
  var body: some View {
    Section("Cellular Data Usage") {
      HStack {
        Spacer()
        VStack {
          Text("Turn Cellular Data On/Off")
            .padding()
          Button {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
          } label: {
            Text("Go to Settings")
          }
          .buttonStyle(.bordered)
          .padding()
        }
        Spacer()
      }
      
      //      HStack {
      //        Spacer()
      //        Button {
      //          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
      //        } label: {
      //          Text("Turn Cellular Data On/Off")
      //        }
      //        Spacer()
      //      }
      //      .padding()
    }
  }
}
