import XCTest
@testable import Favorite

final class FavoriteTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Favorite().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
