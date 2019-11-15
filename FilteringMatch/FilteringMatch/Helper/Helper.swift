//
//  Helper.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

typealias FilterBlock = ((_ hasPhoto: Bool , _ inContactBool: Bool , _ favourite: Bool , _ compatibilityScore: Double, _ age: Int, _ height: Int) -> Void)
