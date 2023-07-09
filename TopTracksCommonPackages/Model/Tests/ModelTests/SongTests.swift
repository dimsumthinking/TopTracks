import XCTest
@testable import Model
import SwiftData


final class SongTests: XCTestCase {
  
  @MainActor
  let previewContainer: ModelContainer = {
    do {
      let container = try ModelContainer(
        for: TopTracksSong.self, ModelConfiguration(inMemory: true)
      )
//      for card in SampleDeck.contents {
//        container.mainContext.insert(object: card)
//      }
      return container
    } catch {
      fatalError("Failed to create container")
    }
  }()
  
  override func setUpWithError() throws {

  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testSetup() throws {
    XCTAssertNotNil(previewContainer)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
