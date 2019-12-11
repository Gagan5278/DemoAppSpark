//
//  FakeModel.swift
//  FilteringMatchTests
//
//  Created by Gagan Vishal on 2019/12/11.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
@testable import FilteringMatch


class FakeModel {
    fileprivate class func createFakeModel() -> Data {
        let fakeRepoListModel = Data("""
        {
        "matches": [
          {
            "display_name": "Caroline",
            "age": 41,
            "job_title": "Corporate Lawyer",
            "height_in_cm": 153,
            "city": {
              "name": "Leeds",
              "lat": 53.801277,
              "lon": -1.548567
            },
            "main_photo": "http://thecatapi.com/api/images/get?format=src&type=gif",
            "compatibility_score": 0.76,
            "contacts_exchanged": 2,
            "favourite": true,
            "religion": "Atheist"
          }
         ]
        }
        """.utf8)
        return fakeRepoListModel
    }
    
    //MARK:- get Fake Repo model
    class func getFakeModel() -> [PersonCodable]?
    {
        let data = FakeModel.createFakeModel()
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(RequestCodable.self, from: data)
            return genericModel.matches
        } catch  {
            print(error)
            return nil
        }
    }
}
