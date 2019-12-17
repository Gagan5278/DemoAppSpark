//
//  CustomAlertTest.swift
//  ProfileTests
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import Profile

class CustomAlertTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK:- Alert Test
    func testCustomAlert() {
        if let rootController =  UIApplication.shared.windows.first?.rootViewController {
            CustomAlert.showUserAlert(with: "Title", message: "message", buttonTitle: "OK", onViewController: rootController, withCallback: self.okButtonAlertAction(action:))
        }
    }
    
    fileprivate func okButtonAlertAction(action: UIAlertAction)
    {
        print("OK Button Pressed")
    }

}
