//import SwiftUI
//
//struct OnBoardingIntroView {
//  @State private var showNext = false
//}
//
//extension OnBoardingIntroView: View {
//  var body: some View {
//    ScrollView {
//      VStack {
//        Text("The songs you choose from an Apple Music Playlist will rotate using this clock.")
//          .multilineTextAlignment(.center)
//          .padding()
//        ClockAndLegendView(clock: .hourWithSpice,
//                           categories: expandedCategories)
//        Button("Next", action: {showNext = true})
//          .buttonStyle(.borderedProminent)
//          .padding()
//        NavigationLink(isActive: $showNext) {
//          OnBoardingDecadesView()
//        } label: {
//          EmptyView()
//        }
//        
//      }
//    }
//    .navigationTitle("The Basic Clock")
//    .navigationBarTitleDisplayMode(.inline)
//  }
//}
//
//struct OnBoardingIntroView_Previews: PreviewProvider {
//  static var previews: some View {
//    OnBoardingIntroView()
//      .previewDevice("iPhone 13 mini")
//  }
//}
