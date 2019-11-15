//
//  PersonViewModel.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

protocol PersonViewProtocol {
    var personName: String {get}
    var personAge: Int {get}
}

extension PersonCodable: PersonViewProtocol {
    var personAge: Int {
        return self.age
    }
    
    var personName: String {
        return self.display_name
    }
}

class PersonViewModel {
    var showLoadingHud: Bindable = Bindable(false)
    let personBind = Bindable([PersonTableTypes]())
    //MARK:- AllBeneficiarie
    fileprivate func personRecord(_ matches: [PersonCodable]?) {
        if matches!.isEmpty {
            self.personBind.value = [.empty]
        }
        else {
            self.personBind.value = matches!.compactMap{.normal(personViewModel: $0)}
        }
    }
    
    //MARK:- Fetch all users
    func getWiAllPersons()
    {
        showLoadingHud.value = true
        let result = try? RequestCodable.fromJSON("matches") as RequestCodable?
        let matches = result?.matches
        personRecord(matches)
        self.showLoadingHud.value = false
    }

    //MARK:- Fetch filtered items
    func getFilterdPerson(hasPhoto: Bool = false, inContactBool: Bool = false, favourite: Bool = false, compatibilityScore: Double = 0.01, age: Int = 18, height: Int = 135){
        let result = try? RequestCodable.fromJSON("matches") as RequestCodable?
        let matches = result?.matches
        showLoadingHud.value = true
        let filteredArray = matches?.filter({$0.age >= age && $0.height_in_cm >= height && $0.compatibility_score >= compatibilityScore && ( favourite ?  $0.favourite == true : ($0.favourite == true || $0.favourite == false)) && (inContactBool ? $0.contacts_exchanged >= 1 : $0.contacts_exchanged >= 0 ) && (hasPhoto ? $0.main_photo != nil : ($0.main_photo != nil || $0.main_photo == nil ))})
        personRecord(filteredArray)
        self.showLoadingHud.value = false
    }
    
    enum PersonTableTypes {
        case normal(personViewModel: PersonViewProtocol)
        case empty
    }
}
