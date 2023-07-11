import SwiftUI
import Model

struct StationNameView {
  let station: TopTracksStation
  @Binding var isChangingName: Bool
  @State var stationName = ""
}

extension StationNameView: View {
  var body: some View {
    if isChangingName {
      Form {
        HStack {
          TextField(station.name, text: $stationName)
            .font(.headline)
            .background(Color.black.opacity(0.4))
            .border(Color.secondary)
            .multilineTextAlignment(.center)
            .onSubmit {
              isChangingName = false
              station.stationName = stationName
            }
          Button {
            station.stationName = stationName
            isChangingName = false
          } label: {
            Image(systemName: "checkmark")
          }
          .buttonStyle(.bordered)
          Button {
            stationName = station.stationName
          } label: {
            Image(systemName: "arrow.uturn.backward.circle")
          }
          .buttonStyle(.bordered)
        }
      }
      .onAppear {
        stationName = station.stationName
      }
    } else {
      Text(station.name)
        .padding(.bottom, 8)
        .multilineTextAlignment(.leading)
        .lineLimit(3)
        .onLongPressGesture(minimumDuration: 1.0,
                            maximumDistance: 10) {
          isChangingName = true
        }
    }

  }
}
