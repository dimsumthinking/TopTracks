import SwiftUI

struct OnBoardingIntroView {
  @State private var showNext = false
}

extension OnBoardingIntroView: View {
  var body: some View {
    VStack {
      Text("""
           The songs you choose from an
           Apple Music Playlist will
           rotate using this clock.
           """)
        .multilineTextAlignment(.center)
      ClockView(hour: Hour(with: RotationClock.hourWithSpice))
        .padding(.horizontal)
        .mask(Rectangle().aspectRatio(1.0, contentMode: .fit))
      ForEach(expandedCategories) {category in
        Text(category.description)
          .foregroundColor(category.color)
      }
      Button("Next", action: {showNext = true})
        .buttonStyle(.bordered)
        .padding()
      NavigationLink(isActive: $showNext) {
        OnBoardingDecadesView()
      } label: {
        EmptyView()
      }
      
    }
    .navigationTitle("The Basic Clock")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct OnBoardingIntroView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingIntroView()
      .previewDevice("iPhone 13 mini")
  }
}
