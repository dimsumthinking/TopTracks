import SwiftData

let backgroundModelActor = BackgroundModelActor()

 struct BackgroundModelActor {
  var context: ModelContext {
    ModelContext(CommonContainer.shared.container)
  }
}


