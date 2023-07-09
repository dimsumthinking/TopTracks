//extension TopTracksStation {
//  @discardableResult
//  public func saveIfPossible() -> Bool {
//    guard let managedObjectContext else { return false }
//    do {
//      try managedObjectContext.save()
//      return true
//    } catch {
//      print(error)
//      return false
//    }
//  }
//}
//
//
//extension TopTracksStation {
//  public func saveInContext() throws {
//    guard let managedObjectContext else {
//      throw MissingManagedObjectContext()
//    }
//    try managedObjectContext.save()
//  }
//}
//
//
//public struct MissingManagedObjectContext: Error {}
//
