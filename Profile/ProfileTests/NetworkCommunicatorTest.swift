//
//  NetworkCommunicatorTest.swift
//  ProfileTests
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import Profile

class NetworkCommunicatorTest: XCTestCase {
    var networkCommunicator: NetworkCommunicator!

    override func setUp() {
        networkCommunicator = NetworkCommunicator()
    }

    override func tearDown() {
        networkCommunicator =  nil
    }

        //MARK:- Test Repo List
    func tesProfileFetch()
    {
        let expectationObeject = expectation(description: "Fetch profile")
        var fakeModel: ProfileModel?
        self.networkCommunicator.fetchUserChoice(value: ProfileModel.self){ (result) in
            switch result {
             case .success(let item):
                      fakeModel = item
             case .failure(_):
                break
            }
            expectationObeject.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(fakeModel)
    }
    
    //MARK:- Test Contributers list fetching
    func testCityFetch() {
        let expectationObeject = expectation(description: "Fetch city")
        var fakeModel: CityModel?
        self.networkCommunicator.fetchRegionList(value: CityModel.self) { (result) in
            switch result {
             case .success(let items):
                      fakeModel = items
             case .failure(_):
                break
            }
            expectationObeject.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(fakeModel)
    }
}
