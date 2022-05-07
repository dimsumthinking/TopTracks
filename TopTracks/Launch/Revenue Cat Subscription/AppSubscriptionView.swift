import SwiftUI

struct AppSubscriptionView {
  
}

extension AppSubscriptionView: View {
  var body: some View {
    VStack {
    Text("Subscribe")
      List(AppSubscriptionType.allCases) {type in
        Text(type.description)
        
      }
    }
  }
}

struct AppSubscriptionView_Previews: PreviewProvider {
  static var previews: some View {
    AppSubscriptionView()
  }
}
