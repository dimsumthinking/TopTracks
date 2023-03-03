import CoreData

public let sharedViewContext = PersistenceController.shared.container.viewContext

public struct PersistenceController {
  static let shared = PersistenceController()
  static var newBackgroundContext: NSManagedObjectContext {
    PersistenceController.shared.container.newBackgroundContext()
  }
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    return result
  }()
  
  let container: NSPersistentCloudKitContainer
  
  init(inMemory: Bool = false) {
    let managedObjectModel = NSManagedObjectModel(contentsOf: Bundle.module.url(forResource: "Stations", withExtension: "momd")!)
    container = NSPersistentCloudKitContainer(name: "Stations",
    managedObjectModel: managedObjectModel!)
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        print("================> error loading store")
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
