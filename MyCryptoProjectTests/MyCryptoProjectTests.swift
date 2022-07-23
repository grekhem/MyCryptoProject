//
//  MyCryptoProjectTests.swift
//  MyCryptoProjectTests
//
//  Created by Grekhem on 03.07.2022.
//

import XCTest
@testable import MyCryptoProject

class MyCryptoProjectTests: XCTestCase {
    
    var network = NetworkService()
    var iteractor: HomeIteractor?

    override func setUpWithError() throws {
            try super.setUpWithError()
        iteractor = HomeIteractor(networkService: network)
    }

    override func tearDownWithError() throws {
        iteractor = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssert(iteractor)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
