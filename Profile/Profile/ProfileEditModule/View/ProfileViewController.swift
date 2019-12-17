//
//  ProfileViewController.swift
//  Profile
//
//  Created Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//


import UIKit

class ProfileViewController: UIViewController {
    //IBOutlet
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet var textFieldItems: [UITextField]!{  //tags are 1, 2 3,4 and 5
        willSet {
            newValue.forEach({
                $0.drawUnderline(withColor: UITextField.Attributes.underlineColor, width: UITextField.Attributes.lineWidth)
                $0.layer.masksToBounds = true
                $0.delegate = self
            })
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //Craete DataPickerView
    var dataPicker : DataPickerView = {
        let datePicker = DataPickerView()
        //2. set date picker frame here to hide it
        datePicker.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height), width: (UIScreen.main.bounds.width), height: 200.0)
        datePicker.backgroundColor = UIColor.white
        return datePicker
    }()
    //Add tool bar
    let toolBar : UIToolbar = {
        let keyboardToolBar = UIToolbar(frame: CGRect(x: CGFloat(0), y: UIScreen.main.bounds.size.height, width:UIScreen.main.bounds.size.width, height: CGFloat(40)))
        keyboardToolBar.barStyle = .black
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClick))
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceButton.width = 15.0
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(hidePickerView))
        keyboardToolBar.setItems([spaceButton, cancelButton, flexibleSpaceButton, doneButton, spaceButton], animated: true)
        keyboardToolBar.sizeToFit()
        return keyboardToolBar
    }()
    //selected textfield
    var selectedTextfieldItem : UITextField!
    //
    var profileModel: ProfileModel?
    var cites: CityModel?
    //ProfilePresenterProtocol Object
	var presenter: ProfilePresenterProtocol?
   //MARK:- View Controller life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        //1. fetch profile
        presenter?.fetchProfile()
        //2. add picker view
        UIApplication.shared.windows.first?.addSubview(self.dataPicker)
        dataPicker.onDataSelected = { [weak self](name: String) in
            self?.selectedTextfieldItem.text = "\(name)"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardDidShowNotification(scrollView: self.containerScrollView)
        registerForKeyboardWillHideNotification(scrollView: self.containerScrollView)
    }
    
    //MARK:- Hide or show activity Indicator
    fileprivate func isActivityIndcicator(hidden: Bool) {
        self.activityIndicator.isHidden = hidden
    }
    
    //MARK:- present Picker
    func doDatePicker(textfield: UITextField){
        textfield.inputView = dataPicker
        textfield.inputAccessoryView = toolBar
    }
    //MARK:- Date picker actions Done
    @objc func doneClick() {
        self.dataPicker.setSelectedItem(at: self.dataPicker.selectedRow(inComponent: 0))
        hidePickerView()
    }
    
    //MARK:- Hide date picker added on View
    @objc func hidePickerView()
    {
        self.selectedTextfieldItem.resignFirstResponder()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func didRecieveProfile(item: ProfileModel) {
        self.profileModel = item
        if self.cites == nil {
          presenter?.fetchRegion()
        }
    }
    
    func didFailWith(error: APIError) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.showAlert(with: "Error", message: error.customDescription, view: self!, withCallback: nil)
        }
    }
    
    func didStartLoadingIndicator() {
        isActivityIndcicator(hidden: false)
    }
    
    func didStopLoadingIndicator() {
        isActivityIndcicator(hidden: true)
    }
    
    func didRecieveCity(item: CityModel)
    {
        if self.cites == nil {
            self.cites = item
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:  //Gender
            self.dataPicker.listOfItems = self.profileModel?.gender
        case 2: //Ethinicity
            self.dataPicker.listOfItems = self.profileModel?.ethnicity
        case 3:  //Religion
            self.dataPicker.listOfItems = self.profileModel?.religion
        case 4:  //Figure
            self.dataPicker.listOfItems = self.profileModel?.figure
        case 5:  //Marital Status
            self.dataPicker.listOfItems = self.profileModel?.marital_status
        case 6:  //Location
            self.dataPicker.listOfItems = self.cites?.cities
        default:
            break
        }
        self.selectedTextfieldItem = textField
        doDatePicker(textfield: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return (self.profileModel != nil)
    }
}
