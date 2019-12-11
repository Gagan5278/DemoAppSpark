//
//  FilterTableViewControllerTest.swift
//  FilteringMatchTests
//
//  Created by Gagan Vishal on 2019/12/11.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import FilteringMatch

class FilterTableViewControllerTest: XCTestCase {
    var filterTableViewController: FilterTableViewController!
    override func setUp() {
        if let controller = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "FilterTableView") as? FilterTableViewController {
            self.filterTableViewController = controller
            self.filterTableViewController.loadView()
            self.filterTableViewController.viewDidLoad()
        }
    }

    override func tearDown() {
        self.filterTableViewController = nil
    }
    
    //MARK:- Test view available or not
    func testMainView() {
        XCTAssertNotNil(self.filterTableViewController.view)
    }

    //MARK:- Test TableView
    func testTableView() {
        XCTAssertNotNil(self.filterTableViewController.tableView)
    }

    //MARK:- Test TableView Delegate
    func testTableViewDelegate() {
        XCTAssertNotNil(self.filterTableViewController.tableView.delegate)
    }
    
    //MARK:- Test TableView DataSource
    func testViewHasTableViewDataSource()
    {
        XCTAssertNotNil(self.filterTableViewController.tableView.dataSource)
    }
    
    //MARK:- Test View Confrim DataSource Protocol
    func testViewConfirmTableViewDataSource() {
        
        XCTAssertTrue(self.filterTableViewController.conforms(to: UITableViewDataSource.self), "View does not confirm tableView DataSource")
    }
    
    //MARK:- Test Right bar button item
      func testRightBarButton(){
          XCTAssertNotNil(self.filterTableViewController.navigationItem.rightBarButtonItem)
      }
    
    //MARK:- Test Right bar button action target
    func testFirstRightBarButtonItemWithTargetCorrectlyAssigned() {
        if let rightBarButtonItem = self.filterTableViewController.navigationItem.rightBarButtonItem{
            barButtonTargetTest(rightBarButtonItem)
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    fileprivate func barButtonTargetTest(_ barButtonItem: UIBarButtonItem) {
        XCTAssertNotNil(barButtonItem.target)
        XCTAssert(barButtonItem.target === self.filterTableViewController)
    }

    //MARK:- Test First Left Bar Button Action
    func testRightBarButtonAction() {
        if let rightBarButton = self.filterTableViewController.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(self.filterTableViewController.doneButtonPressed(rightBarButton.action as Any))
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testDidSelectRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.filterTableViewController.tableView(self.filterTableViewController.tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(self.filterTableViewController.getBoolFor(indexPath: indexPath))
    }

}
