import Combine
import MusicKit

class TopTracksStatus: ObservableObject {
  @Published var isCreatingNew = true
  @Published var musicSubscription: MusicSubscription?
  @Published var needsAppSubscription = false
}
