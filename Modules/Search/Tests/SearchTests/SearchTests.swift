import XCTest
@testable import Search

final class SearchTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Search().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
