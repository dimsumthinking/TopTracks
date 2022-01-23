class Hour {
  private let slots: [RotationCategory]
  private(set) var index = 0
  
  init(with clock: RotationClock) {
    self.slots = clock.slots
  }
  
}

extension Hour {
  func nextCategory() -> RotationCategory {
    moveToNextSlot()
    return currentCategory
  }
  
  private func moveToNextSlot()  {
    index = indexAfterIncrement
  }
  
  private var currentCategory: RotationCategory {
    slots[index]
  }
  
  private var indexAfterIncrement: Int {
    (index + 1) % numberOfSlots
  }
  
  var numberOfSlots: Int {
    slots.count
  }
  
  func categoryFor(slot index: Int) -> RotationCategory {
    slots[index]
  }
}
