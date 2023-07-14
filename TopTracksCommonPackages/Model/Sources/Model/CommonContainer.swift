import SwiftData

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
  
  @MainActor
  func save(message: String = "") {
    do {
      try container.mainContext.save()
    } catch {
      print("Unable to save \(message)")
    }
  }
  
  @MainActor
  func insert(_ object: any PersistentModel) {
    container.mainContext.insert(object: object)
    save()
  }
  
  @MainActor
  func delete(_ object: any PersistentModel) {
    container.mainContext.delete(object)
    save()
  }
}
