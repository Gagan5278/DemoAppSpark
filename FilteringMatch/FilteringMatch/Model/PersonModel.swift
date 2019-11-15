//
//  Struct.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct RequestCodable:Decodable {
    let matches:[PersonCodable]
}

struct PersonCodable:Decodable {
    let display_name:String
    let age:Int
    let job_title: String
    let height_in_cm: Int
    let main_photo: String?
    let compatibility_score: Double
    let contacts_exchanged: Int
    let favourite: Bool
    let religion: String
    let city: CityModel?
    
    private enum CodingKeys: String, CodingKey {
        case display_name
        case age
        case job_title
        case height_in_cm
        case main_photo
        case compatibility_score
        case contacts_exchanged
        case favourite
        case religion
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.display_name = try container.decode(String.self, forKey: .display_name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.job_title = try container.decode(String.self, forKey: .job_title)
        self.height_in_cm = try container.decode(Int.self, forKey: .height_in_cm)
        self.main_photo = try container.decodeIfPresent(String.self, forKey: .main_photo)
        self.compatibility_score = try container.decode(Double.self, forKey: .compatibility_score)
        self.contacts_exchanged = try container.decode(Int.self, forKey: .contacts_exchanged)
        self.favourite = try container.decode(Bool.self, forKey: .favourite)
        self.religion = try container.decode(String.self, forKey: .religion)
        self.city =  try container.decodeIfPresent(CityModel.self, forKey: .city)
    }
}

//MARK:- Location/City Model
struct CityModel: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
    }
}
