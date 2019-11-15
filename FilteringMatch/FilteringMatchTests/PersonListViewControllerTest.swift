//
//  PersonListViewControllerTest.swift
//  FilteringMatchTests
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import FilteringMatch

class PersonListViewControllerTest: XCTestCase {
    var  personListViewControllerObject: PersonListViewController?
    override func setUp() {
        if let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "PersonListView") as? PersonListViewController {
            self.personListViewControllerObject = viewController
            self.personListViewControllerObject?.loadView()
        }
    }

    override func tearDown() {
        self.personListViewControllerObject = nil
    }

    func testViewLoaded() {
        XCTAssertNotNil(self.personListViewControllerObject?.view, "Unable to load view.")
    }
    
    func testTableViewIsNotNil() {
        XCTAssertNotNil(self.personListViewControllerObject?.personTableView, "Unable to load view.")
    }
    
    func testViewHasATableView()
    {
        XCTAssertTrue((self.personListViewControllerObject?.view.subviews.contains(self.personListViewControllerObject!.personTableView))!, "Could not find UITableView")
    }
    
    func testTableViewConnectedToDelegate() {
        
    }
    
    func testViewConfirmTableViewDelegate() {
        
    }

    func testTableViewConnectedToProtocol() {
        
    }
    
    func testViewConfirmTableViewDataSource() {
        
    }
    
    func testNumberOfSectionInTableView(){
        
    }
    
    func testNumberOfRowsInSection()
    {
        
    }

}
