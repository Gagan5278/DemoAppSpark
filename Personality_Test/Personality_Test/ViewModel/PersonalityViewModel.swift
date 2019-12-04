//
//  PersonalityViewModel.swift
//  Personality_Test
//
//  Created by Gagan Vishal on 2019/12/04.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
protocol PersonalityProtocol {
    func getAllItemsForGivenCategory(category: String)
}

extension PersonalityModel: PersonalityProtocol {
    func getAllItemsForGivenCategory(category: String) {
        
    }
}

class PersonalityViewModel {
    var dictOfCategoriesItems = Dictionary<String,[QuestionsModel]>()

    func fetchAllPersonalityItems() {
        let result = try? PersonalityModel.fromJSON("personality_test") as PersonalityModel?
        resetItemsAsPerCatrgory(item:result)
    }
    
    func resetItemsAsPerCatrgory(item: PersonalityModel?) {
        if item == nil {
            return
        }
        
        if let hard_fact = item?.categories.hard_fact {
            dictOfCategoriesItems[hard_fact] = item?.questions.filter({$0.category == hard_fact}) //first(where: {$0.category == hard_fact})
        }
        
        if let introversion = item?.categories.introversion {
            dictOfCategoriesItems[introversion] = item?.questions.filter({$0.category == introversion})
        }
        
        if let lifestyle = item?.categories.lifestyle {
            dictOfCategoriesItems[lifestyle] = item?.questions.filter({$0.category == lifestyle})
        }
        
        if let passion = item?.categories.passion {
            dictOfCategoriesItems[passion] = item?.questions.filter({$0.category == passion})
        }
    }

    //MARK:- Get number of sction
    func getNumberOfSection() -> Int {
        return dictOfCategoriesItems.count
    }
    
    func getNumberOfRowsIn(section : Int) -> Int {
        let key = ([String](dictOfCategoriesItems.keys))[section]
        return dictOfCategoriesItems[key]?.count ?? 0
    }
    
    func headerTitle(at section: Int) -> String {
        return ([String](dictOfCategoriesItems.keys))[section]
    }
    
    //MARK:- Get QuestionsModel
    func getQuestionsModel(at indexPath: IndexPath) -> QuestionsModel {
        let key = ([String](dictOfCategoriesItems.keys))[indexPath.section]
        return dictOfCategoriesItems[key]![indexPath.row]
    }
}
