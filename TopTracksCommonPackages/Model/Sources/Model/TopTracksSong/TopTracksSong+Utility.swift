extension TopTracksSong {
  @discardableResult
  public func saveIfPossible() -> Bool {
    guard let managedObjectContext else { return false }
    do {
      try managedObjectContext.save()
      return true
    } catch {
      print(error)
      return false
    }
  }
}
