import SwiftUI

struct ClockAndLegendView {
  let clock: RotationClock
  let categories: [RotationCategory]
}

extension ClockAndLegendView: View {
  var body: some View {
    VStack {
      ClockView(hour: Hour(with: clock))
        .padding(.horizontal)
        .mask(Rectangle().aspectRatio(1.0, contentMode: .fit))
      CategoryRepeatView()
    }
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("The clock consists of 15 songs picked from the categories: Top Tracks, Recent Favorites, Newly Added, and Extra Spice. There are six Top Tracks so the songs in this category rotate the fastest. There are four Recent Favorites, three Newly Added, and two Extra Spice.")
  }
}

struct ClockAndLegend_Previews: PreviewProvider {
  static var previews: some View {
    ClockAndLegendView(clock: .hourWithSpice,
                       categories: expandedCategories)
  }
}
