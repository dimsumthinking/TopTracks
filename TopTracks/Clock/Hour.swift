//let defaultHour
//= Hour(with: [.power, .current, .added,
//              .power, .current, .gold,
//              .power, .added,
//              .power, .current,
//              .power, .added, .current,
//              .power, .spice])

let hourWithGold
= Hour(with: [.power, .current, .added,
              .power, .current, .gold,
              .power, .added,
              .power, .current,
              .power, .added, .current,
              .power, .gold])

let hourWithSpice
= Hour(with: [.power, .current, .added,
              .power, .current, .spice,
              .power, .added,
              .power, .current,
              .power, .added, .current,
              .power, .spice])

let hourWithGoldAndSpice
= Hour(with: [.power, .current, .added,
              .power, .current, .gold,
              .power, .added,
              .power, .current,
              .power, .added, .current,
              .power, .spice])

class Hour {
  private let slots: [RotationCategory]
  private(set) var index = 0
  
  init(with slots: [RotationCategory], index: Int = -1) {
    self.slots = slots
    self.index = (index + slots.count) % slots.count
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
