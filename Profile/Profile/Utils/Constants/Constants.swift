//
//  Constants.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
enum Constants {
    enum AppURLConstants {
        public static let base_url = "http://localhost:8080/en/"
        public static let single_choice = "single_choice_attributes.json"
        public static let locations = "locations/cities.json"
    }
    
    /// Network error title & message
    enum Internet_Availibility {
        public static let networkErrorTitle  = "No Internet Connectivity"
        public static let netowrkErrorMessage = "There is currently no Internet connection available.\n\nPlease check your connection and try again."
    }
    
    ///Constant messages string used in the app
    enum User_Messages {
        public static let serviceFailureErrorMessage = "Something went wrong. Unable to fetch repo from server."
    }
}
