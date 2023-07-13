import SwiftData
import Model

public class CommonContainer {
  public static let shared = CommonContainer()
  public let container: ModelContainer
  
  init() {
    do {
      self.container = try ModelContainer(for: TopTracksStation.self)
    } catch {
      fatalError("Could not connect to data store")
    }
  }
}
