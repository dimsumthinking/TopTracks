class Hour {
  let slots: [RotationCategory]
  private(set) var index = 0
  let numberOfSlots: Int
  
  init(with clock: RotationClock) {
    self.slots = clock.slots
    self.numberOfSlots = clock.numberOfSlots
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
  
//  var numberOfSlots: Int {
//    slots.count
//  }
  
  func categoryFor(slot index: Int) -> RotationCategory {
    slots[index]
  }
}
