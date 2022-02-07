import Combine
import MusicKit

class TopTracksStatus: ObservableObject {
  @Published var isCreatingNew = false
  @Published var musicSubscription: MusicSubscription?
  @Published var needsAppSubscription = true
}
