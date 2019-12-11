//
//  PersonListViewControllerTest.swift
//  FilteringMatchTests
//
//  Created by Gagan Vishal on 2019/11/15.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import FilteringMatch

class PersonListViewControllerTest: XCTestCase { 
    var personListViewControllerObjcet: PersonListViewController!
        
    override func setUp() {
        controllerSetup()
    }

    override func tearDown() {
        personListViewControllerObjcet =  nil
    }

    fileprivate func controllerSetup() {
        if let controller =  UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "PersonListView") as? PersonListViewController {
            personListViewControllerObjcet = controller
            personListViewControllerObjcet.loadView()
            personListViewControllerObjcet.viewDidLoad()
        }
    }
    
    //MARK:- Test view available or not
    func testMainView() {
        XCTAssertNotNil(self.personListViewControllerObjcet.view, "Could not find personListViewControllerObjcet")
    }

    //MARK:- Test TableView
    func testTableView() {
        XCTAssertNotNil(self.personListViewControllerObjcet.personTableView, "Could not find TableView")
    }
    
    //MARK:- Test View has a tableView
    func testViewHasATableViewAsSubView()
    {
        XCTAssertTrue((self.personListViewControllerObjcet.view.subviews.contains(self.personListViewControllerObjcet.personTableView)), "View does not contain UITableView as subview")
    }
    
    //MARK:- Test TableView Delegate
    func testTableViewDelegate() {
        XCTAssertNotNil(self.personListViewControllerObjcet.personTableView.delegate, "TableView Delegate is nil")
    }
    
    //MARK:- Test TableView DataSource
    func testViewHasTableViewDataSource()
    {
        XCTAssertNotNil(self.personListViewControllerObjcet.personTableView.dataSource, "Table view data source is nil")
    }
    
    //MARK:- Test View Confrim DataSource Protocol
    func testViewConfirmTableViewDataSource() {
        
        XCTAssertTrue(self.personListViewControllerObjcet.conforms(to: UITableViewDataSource.self), "View does not confirm tableView DataSource")
    }
    
    //MARK:- Test Right bar button item
     func testRightBarButton(){
         XCTAssertNotNil(self.personListViewControllerObjcet.navigationItem.rightBarButtonItem)
     }
     
    //MARK:- Test Right bar button action target
    func testFirstRightBarButtonItemWithTargetCorrectlyAssigned() {
        if let rightBarButtonItem = self.personListViewControllerObjcet.navigationItem.rightBarButtonItems?.first{
            barButtonTargetTest(rightBarButtonItem)

        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testSecondRightBarButtonItemWithTargetCorrectlyAssigned() {
        if let rightBarButtonItem = self.personListViewControllerObjcet.navigationItem.rightBarButtonItems?[1]{
            barButtonTargetTest(rightBarButtonItem)

        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    fileprivate func barButtonTargetTest(_ barButtonItem: UIBarButtonItem) {
        XCTAssertNotNil(barButtonItem.target)
        XCTAssert(barButtonItem.target === self.personListViewControllerObjcet)
    }
    
    //MARK:- Test First Left Bar Button Action
    func testHasFirstRightBarButtonAction() {
        if let rightBarButton = self.personListViewControllerObjcet.navigationItem.rightBarButtonItems?.first {
            XCTAssertNotNil(self.personListViewControllerObjcet.filterButtonClicked(rightBarButton.action as Any))
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testHasSecondBarButtonAction() {
        if let rightBarButton = self.personListViewControllerObjcet.navigationItem.rightBarButtonItems?[1] {
            XCTAssertNotNil(self.personListViewControllerObjcet.fetchAllUserListOnRightBarButtonClick(rightBarButton.action as Any))
        }
        else {
            XCTAssertTrue(false)
        }
    }
    //MARK:- Test Number of rows in UITableView
    func testNumberOfRowsInTableView()
    {
        fakeModelSetup()
        let tableView = personListViewControllerObjcet.personTableView
        XCTAssertEqual(self.personListViewControllerObjcet.personViewModel.personBind.value.count, tableView!.dataSource?.tableView(tableView!, numberOfRowsInSection: 0))
    }
    
    //MARK:- Test cellForRowAtIndexPath
    func testForCellInUITableView()
    {
        fakeModelSetup()
         let itemCell = self.personListViewControllerObjcet.personTableView.dequeueReusableCell(withIdentifier: self.personListViewControllerObjcet.cellIdentifier)
        XCTAssertNotNil(itemCell, "UITableViewCell not found in UITableView")
    }
    
    fileprivate func fakeModelSetup()
    {
        if let model = FakeModel.getFakeModel() {
            self.personListViewControllerObjcet.personViewModel.personBind.value = model.compactMap{.normal(personViewModel: $0)}
        }
    }
    
    //MARK: test getFilterdPerson
    func testGetFilterdPerson() {
       _ = self.personListViewControllerObjcet.personViewModel.getFilterdPerson(hasPhoto: true, inContactBool: true, favourite: false, compatibilityScore: 0.4, age: 45, height: 10)
        XCTAssertTrue(self.personListViewControllerObjcet.personViewModel.personBind.value.count != 0)
    }
}
