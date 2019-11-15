

//
//  Int+Extensions.swift
//  FilteringMatch
//
//  Created by Gagan Vishal on 2019/11/14.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
extension String {
    //MARK:- Get numeric and decimal from string
     func parseNumericDecimalValue() -> Double {
        return Double(self.components(separatedBy: CharacterSet.init(charactersIn: "0123456789.").inverted).joined(separator: ""))!
    }
}
