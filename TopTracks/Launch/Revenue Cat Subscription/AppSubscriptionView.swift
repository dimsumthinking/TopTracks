import SwiftUI

struct AppSubscriptionView {
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @Binding var isShowingAppSubscriptions: Bool
}

extension AppSubscriptionView: View {
  var body: some View {
    VStack {
    Text("\(topTracksStatus.activeAppSubscriptionType.description) Subscription")
        .font(.headline)
        .padding()
        .padding(.vertical)
      VStack (alignment: .leading){
        HStack {
          Image(systemName: "plus.circle.fill")
            .font(.largeTitle)
            .padding(.trailing)
          Text(topTracksStatus.activeAppSubscriptionType.currentLevelTextStart)
        }
        .padding()
              if let expirationDate = topTracksStatus.activeAppExpirationDate,
           topTracksStatus.activeAppSubscriptionType != .none {
        HStack {
          Image(systemName: "staroflife.circle.fill")
            .font(.largeTitle)
            .padding(.trailing)
          Text(topTracksStatus.activeAppSubscriptionType.cancelByText(expirationDate: expirationDate))
        }
        .padding()
           }

        HStack {
          Image(systemName: "arrow.up.circle.fill")
            .font(.largeTitle)
            .padding(.trailing)
          Text(topTracksStatus.activeAppSubscriptionType.currentLevelTextFinish)
        }
        .padding()
      }
      
      if let subscriptionOffers = topTracksStatus.activeAppSubscriptionType.subscriptionOffers {
        ForEach(subscriptionOffers)  {subscription in
          Button(action: {purchase(subscription)}){
            HStack {
              Spacer()
              Text("\(topTracksStatus.appPrice(for: subscription))")
              Spacer()
            }
          }
          .buttonStyle(.borderedProminent)
          .padding()
        }
        Text("Free one week trial for first time subscribers")
          .font(.caption)
          .padding()
        Button("Dismiss",
               action: {isShowingAppSubscriptions = false})
      }
    }
  }
}

extension AppSubscriptionView {
  private func purchase(_ applicationSubscriptionType: AppSubscriptionType) {
    topTracksStatus.purchase(subscription: applicationSubscriptionType)
  }
}

struct AppSubscriptionView_Previews: PreviewProvider {
  static var previews: some View {
    AppSubscriptionView(isShowingAppSubscriptions: .constant(true)).previewDevice("iPhone 13 Pro Max").environmentObject(TopTracksStatus())
  }
}
