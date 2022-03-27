import Combine
import MusicKit


class TopTracksStatus: ObservableObject {
  @Published var isCreatingNew = false {
    didSet {
      print("Set isCreatingNew to", isCreatingNew)
    }
  }
  @Published var musicSubscription: MusicSubscription?
  @Published var needsAppSubscription = false
}
