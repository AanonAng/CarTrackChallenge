//
//  CarTrack_ChallengeTests.swift
//  CarTrack-ChallengeTests
//
//  Created by Aaron Ang on 3/5/21.
//

import XCTest
@testable import CarTrack_Challenge

class CarTrack_ChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    // Alamofire
    func testUserRequest() {
        let e = expectation(description: "Alamofire")
        ClientService.shared.userRequest { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response, "userRequest not nil")
                self.testUnwrapUserResponse(response: response)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 15.0, handler: nil)
    }
    
    func testUnwrapUserResponse(response: Any) {
        if let array = response as? NSArray {
            XCTAssertNotNil(array, "response is NSArray")
        } else {
            XCTFail("response is not NSArray")
        }
    }
}
