//
//  FakeModel.swift
//  Personality_TestTests
//
//  Created by Gagan Vishal on 2019/12/11.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
@testable import Personality_Test

class FakeModel {
    fileprivate class func createFakeModel() -> Data {
        let fakeRepoListModel = Data("""
        {
        "categories": [
          "hard_fact",
          "lifestyle",
          "introversion",
          "passion"
        ],
        "questions": [
          {
            "question": "What is your gender?",
            "category": "hard_fact",
            "question_type": {
              "type": "single_choice",
              "options": [
                "male",
                "female",
                "other"
              ]
            }
          }
         ]
        }
        """.utf8)
        return fakeRepoListModel
    }
    
    //MARK:- get Fake Repo model
    class func getFakeModel() -> PersonalityModel?
    {
        let data = FakeModel.createFakeModel()
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(PersonalityModel.self, from: data)
            return genericModel
        } catch  {
            print(error)
            return nil
        }
    }
}
