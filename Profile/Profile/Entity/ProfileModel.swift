//
//  ProfileModel.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct ProfileModel: Codable {
    let gender: [Gender]
    let ethnicity: [Ethnicity]
    let religion: [Religion]
    let figure: [Figure]
    let marital_status: [MaritalStatus]
}

struct Gender: Codable {
    let name: String
    let id: String
}

struct Ethnicity: Codable {
    let name: String
    let id: String
}

struct Religion: Codable {
    let name: String
    let id: String
}

struct Figure: Codable {
    let name: String
    let id: String
}

struct MaritalStatus: Codable {
    let name: String
    let id: String
}
