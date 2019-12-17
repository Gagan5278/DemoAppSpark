//
//  ProfileViewControllerTest.swift
//  ProfileTests
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import Profile

class ProfileViewControllerTest: XCTestCase {
    var profileViewController: ProfileViewController!
    override func setUp() {
        controllerSetup()
    }

    override func tearDown() {
        profileViewController = nil
    }

    fileprivate func controllerSetup() {
        if let controller = ProfileRouter.createProfileViewModule().children.first as? ProfileViewController {
            self.profileViewController = controller
            self.profileViewController.loadView()
            self.profileViewController.viewDidLoad()
        }
    }

    //MARK:- Test view available or not
    func testMainView() {
        XCTAssertNotNil(self.profileViewController.view, "Could not find ProfileViewController view")
    }

    //MARK:- Test Textfield Delegate
    func testTextfieldDelegate() {
        XCTAssertNotNil(self.profileViewController.textFieldItems[0].delegate, "TableView Delegate is nil")
    }
    
    //MARK:- Test View Confirm TableView Delegate
    func testViewConfirmTextfieldDelegate()
    {
        XCTAssertTrue(self.profileViewController.conforms(to: UITextFieldDelegate.self), "View does not confirm tableView Delegate")
    }
}
