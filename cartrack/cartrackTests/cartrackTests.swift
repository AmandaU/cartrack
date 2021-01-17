//
//  cartrackTests.swift
//  cartrackTests
//
//  Created by Amanda Baret on 2021/01/16.
//

import XCTest
@testable import cartrack

class cartrackTests: XCTestCase {

    var store: ContactStore!

    override func setUpWithError() throws {
        self.store = ContactStore()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetContact_Success() {
        let validation = expectation(description: "FullFill")
        self.store.getContacts {
            validation.fulfill()
        }
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(!self.store.contacts.isEmpty)
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
