//
//  ViewController.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class PersonListViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var personTableView: UITableView!
    //cell identifier
    let cellIdentifier = "personCell"
    //View Model Object
    let personViewModel = PersonViewModel()
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindModelView()
        loadPersons()
    }

    //MARK:- bindModelView
    private func bindModelView() {
        personViewModel.personBind.bindAndFire{ [weak self] (items) in
            DispatchQueue.main.async { [weak self] in
                if !items.isEmpty
                {
                    self?.personTableView.reloadData()
                }
            }
        }
        
        personViewModel.showLoadingHud.bind() { [weak self] visible in
            DispatchQueue.main.async { [weak self] in
                if visible == false   //If visible the hide
                {
                    self?.activityIndicator.stopAnimating()
                }
                else
                {
                    self?.activityIndicator.startAnimating()
                }
            }
        }
    }

    //MARK:- loadPersons {
    private func loadPersons() {
        personViewModel.getWiAllPersons()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController =  segue.destination as? FilterTableViewController {
            let successBlock: FilterBlock = { [weak self](_ hasPhoto: Bool , _ inContactBool: Bool , _ favourite: Bool , _ compatibilityScore: Double, _ age: Int, _ height: Int) in
                self?.personViewModel.getFilterdPerson(hasPhoto: hasPhoto, inContactBool: inContactBool, favourite: favourite, compatibilityScore: compatibilityScore, age: age, height: height)
            }
            viewController.addSelection(block: successBlock)
        }
    }
    
    //MARK:- Fetch all user list on Bar button action
    @IBAction func fetchAllUserListOnRightBarButtonClick(_ sender: Any) {
        loadPersons()
    }
    //MARK:- Filter button action
    @IBAction func filterButtonClicked(_ sender: Any) {
        self.shouldPerformSegue(withIdentifier: "showFilter", sender: self)
    }
    
}


//MARK:- UITableViewDataSource
extension PersonListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personViewModel.personBind.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch personViewModel.personBind.value[indexPath.row] {
        case .normal(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell()
            }
            cell.textLabel?.text = viewModel.personName
            cell.detailTextLabel?.text = "Age: \(viewModel.personAge)"
            return cell

        case .empty:
            let cell = UITableViewCell()
            cell.textLabel?.text = "No Person Available"
            return cell
        }
    }
}
