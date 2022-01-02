import SwiftUI
import MusicKit

struct NewStationClockExplanationView {
  var playlist: Playlist?
  //  let playlist: Playlist
  @State private var showNext = false
}

extension NewStationClockExplanationView: View {
  var body: some View {
    VStack {
      InstructionView("Each new station uses this rotation clock with fifteen songs in an 'hour'.")
      ClockView(hour: defaultHour)
      VStack {
//      Text("Categories:")
        ForEach(RotationCategory.allCases) {category in
          Text(category.description)
            .font(.title3)
            .foregroundColor(category.color)
        }
      }
      .padding()
//      .border(Color.secondary.opacity(0.3))
//      .background(Color.secondary.opacity(0.1))

      Button("Next", action: {showNext = true})
        .padding()
        .buttonStyle(.bordered)
      NavigationLink(isActive: $showNext) {
        NewStationCategorySelectionView(playlist: playlist)
      } label: {
        EmptyView()
      }
      
    }
    .navigationTitle("The Clock")
  }
}

struct ClockExplanationView_Previews: PreviewProvider {
  static var previews: some View {
    NewStationClockExplanationView()
  }
}


