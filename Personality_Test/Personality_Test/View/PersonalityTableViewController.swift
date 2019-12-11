//
//  PersonalityViewControllerTableViewController.swift
//  Personality_Test
//
//  Created by Gagan Vishal on 2019/12/04.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class PersonalityTableViewController: UITableViewController {
    //cell identifier
    let cellIdentifier = "reuseIdentifier"
    var personalityViewModel = PersonalityViewModel()
    //MARK:- ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        personalityViewModel.fetchAllPersonalityItems()
    }

    
    //MARK:- Get personality list {
    private func loadPersons() {
        personalityViewModel.fetchAllPersonalityItems()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return personalityViewModel.getNumberOfSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalityViewModel.getNumberOfRowsIn(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PersonalityTableViewCell else {
            return UITableViewCell()
        }
        cell.questionModel = personalityViewModel.getQuestionsModel(at: indexPath)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return personalityViewModel.headerTitle(at: section)
    }

}
