//
//  CityModel.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let cities: [Cities]
}

struct Cities: Codable {
    let lat: String
    let lon: String
    let city: String
}
