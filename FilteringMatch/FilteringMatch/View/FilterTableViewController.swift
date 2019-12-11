//
//  FilterTableViewController.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    //IBOutlets
    @IBOutlet weak var capabilityScoreLabel: UILabel!
    @IBOutlet weak var yearRangeLabel: UILabel!
    @IBOutlet weak var userHeightLabel: UILabel!
    //
    var bankSelectionSuccessBlock: FilterBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Add Bank Selection Block
    func addSelection(block: @escaping FilterBlock) {
        self.bankSelectionSuccessBlock = block
    }

    //MARK:- Slider Action
    @IBAction func sliderMoveAction(_ sender: UISlider) {
        let sliderValue = (Int(sender.value.rounded()))
        if sender.tag == 1 {
            let doubleValue = Double((sender.value/100.0))
            self.capabilityScoreLabel.text = "Capability \(doubleValue.roundTo(places: 2))%"
        }
        else if sender.tag == 2 {
            self.yearRangeLabel.text = "Age: \(sliderValue) years"
        }
        else if sender.tag == 3 {
            self.userHeightLabel.text = "Height: \(sliderValue) cm"
        }
    }
    
    //MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell.accessoryType == .none {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            }
        }
    }
    
    
    //MARK:- Done button action
    @IBAction func doneButtonPressed(_ sender: Any) {
        let hasPhoto = getBoolFor(indexPath: IndexPath(row: 0, section: 0))
        let isInContact = getBoolFor(indexPath: IndexPath(row: 1, section: 0))
        let isFavorite = getBoolFor(indexPath: IndexPath(row: 2, section: 0))
        let age = yearRangeLabel.text?.parseNumericDecimalValue()
        let height = userHeightLabel.text?.parseNumericDecimalValue()
        let capability = capabilityScoreLabel.text?.parseNumericDecimalValue()
        self.bankSelectionSuccessBlock?(hasPhoto, isInContact, isFavorite, Double(capability!), Int(age!), Int(height!))
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Get Bool value for selected cell
     func getBoolFor(indexPath: IndexPath) -> Bool {
        return  self.tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none ? false : true
    }
    
}
