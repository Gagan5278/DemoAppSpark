//
//  DataPickerView.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
class DataPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    var onDataSelected: ((_ item: String) -> Void)?
    var listOfItems: [Codable]! {
        didSet {
            self.reloadAllComponents()
        }
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commonSetup()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
    func commonSetup() {
        self.delegate = self
        self.dataSource = self
    }

    
    fileprivate func getName(for item: Codable) -> String {
        if let city = item as? Cities {
            return city.city
        }
        if let gender = item as? Gender {
            return gender.name
        }
        if let ethinicity = item as? Ethnicity {
            return ethinicity.name
        }
        if let figure =  item as? Figure
        {
            return figure.name
        }
        if let religion = item as? Religion {
            return religion.name
        }
        if let statuc = item as? MaritalStatus {
            return statuc.name
        }
        return "n/a"
    }
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return getName(for: listOfItems[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let items = listOfItems {
            return items.count
        }
        return 0
    }
    
    //MARK:- Get Default selected item
    func setSelectedItem(at row: Int) {
        if let block = onDataSelected {
            block(getName(for: listOfItems[row]))
        }
    }
}
