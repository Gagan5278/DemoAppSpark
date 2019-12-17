//
//  FakeProvider.swift
//  ProfileTests
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
@testable import Profile

class FakeProvider {


    //Faking Data
    fileprivate class func createFakeProfileData() -> Data {
        let faketProfileModel = Data("""
        {
            "gender": [{
                "id": "8f9d76ad-2c6b-4a98-8496-6165a2770a5e",
                "name": "Male"
            }],
            "ethnicity": [{
                "id": "5b3d1252-860f-459b-ab90-7a2914360dbf",
                "name": "White"
            }],
            "religion": [{
                "id": "a2bc1142-9b6a-41f3-a620-a39afb1304ab",
                "name": "Agnostic"
            }],
            "figure": [{
                    "id": "9c6ddf44-01ae-4fdb-acc9-b97f2882e4ef",
                    "name": "Slim"
                }

            ],
            "marital_status": [{
                "id": "5a837767-7a11-487c-a243-7451c7b14c03",
                "name": "Never Married"
            }]
        }
        """.utf8)
        return faketProfileModel
    }
    
    fileprivate class func getFakeCityData() -> Data
    {
        let fakecityModel = Data("""
        {
            "cities": [{
                    "lat": "56°09'N",
                    "lon": "10°13'E",
                    "city": "Aarhus"
                },
                {
                    "lat": "57°09'N",
                    "lon": "2°07'W",
                    "city": "Aberdeen"
                }
            ]
        }
        """.utf8)
        return fakecityModel
    }
    //MARK:- get Fake Repo model
    class func getProfileFakeModel() -> ProfileModel?
    {
        let data = FakeProvider.createFakeProfileData()
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(ProfileModel.self, from: data)
            return genericModel
        } catch  {
            print(error)
            return nil
        }
    }
    
    //MARK:- Get Fake Contributers List
    class func getFakeCityModel() -> CityModel?
    {
        let data = FakeProvider.getFakeCityData()
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(CityModel.self, from: data)
            return genericModel
        } catch  {
            print(error)
            return nil
        }
    }
}
