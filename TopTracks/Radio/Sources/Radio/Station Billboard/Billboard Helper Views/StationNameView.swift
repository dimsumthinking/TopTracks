import SwiftUI
import Model
import SwiftData

struct StationNameView {
  let station: TopTracksStation
  @Binding var isChangingName: Bool
  @State var stationName = ""
  @Environment (\.modelContext) private var modelContext: ModelContext
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

extension StationNameView {
  private func changeName() {
    isChangingName = false
    station.stationName = stationName
    do {
      try modelContext.save()
    } catch {
      RadioLogger.stationNameChange.info("Failed to change station name from \(station.stationName) to \(stationName)")
    }
  }
}
