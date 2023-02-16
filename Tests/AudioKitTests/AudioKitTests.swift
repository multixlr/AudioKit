import XCTest
@testable import AudioKit

final class AudioKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AudioKit().text, "Hello, World!")
    }
}
