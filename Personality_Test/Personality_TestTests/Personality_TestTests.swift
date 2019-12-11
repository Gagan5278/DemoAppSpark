//
//  Personality_TestTests.swift
//  Personality_TestTests
//
//  Created by Gagan Vishal on 2019/12/03.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import Personality_Test

class Personality_TestTests: XCTestCase {
    var personalityViewController: PersonalityTableViewController!
    override func setUp() {
        if let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "PersonalityView") as?  PersonalityTableViewController{
            self.personalityViewController = viewController
            self.personalityViewController.loadView()
        }
    }

    override func tearDown() {
     personalityViewController = nil
    }

    //MARK:- Test view available or not
    func testMainView() {
        XCTAssertNotNil(self.personalityViewController.view)
    }

    //MARK:- Test TableView
    func testTableView() {
        XCTAssertNotNil(self.personalityViewController.tableView)
    }

    //MARK:- Test TableView Delegate
    func testTableViewDelegate() {
        XCTAssertNotNil(self.personalityViewController.tableView.delegate)
    }
    
    //MARK:- Test TableView DataSource
    func testViewHasTableViewDataSource()
    {
        XCTAssertNotNil(self.personalityViewController.tableView.dataSource)
    }
    
    //MARK:- Test View Confrim DataSource Protocol
    func testViewConfirmTableViewDataSource() {
        
        XCTAssertTrue(self.personalityViewController.conforms(to: UITableViewDataSource.self), "View does not confirm tableView DataSource")
    }
    
    //MARK:- test Parent View
    func testGetParentView()
    {
       XCTAssertNotNil(self.personalityViewController.view.getParentViewController())
    }
    
    func testForCellInUITableView()
    {
        if let model = self.getFakeModel() {

        if let itemCell = self.personalityViewController.tableView.dequeueReusableCell(withIdentifier: self.personalityViewController.cellIdentifier) as? PersonalityTableViewCell {
            itemCell.questionModel = model.questions.first
            XCTAssertNotNil(itemCell, "UITableViewCell not found in UITableView")
        }
        }
    }
    
    func testModelSetup()
    {
        if let model = self.getFakeModel() {
             self.personalityViewController.personalityViewModel.resetItemsAsPerCatrgory(item: model)
            XCTAssertTrue(!self.personalityViewController.personalityViewModel.dictOfCategoriesItems.isEmpty)
        }
    }
    
    fileprivate func getFakeModel() -> PersonalityModel? {
        return FakeModel.getFakeModel()
    }
}
