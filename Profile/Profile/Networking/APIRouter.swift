//
//  APIRouter.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

enum APIRouter {
    case regoin
    case choice
    
    var requestURLString: String {
        switch self {
        case .choice:
            return Constants.AppURLConstants.base_url + Constants.AppURLConstants.single_choice
        case .regoin:
            return Constants.AppURLConstants.base_url + Constants.AppURLConstants.locations
     }
    }
    
    func asRequest() -> URLRequest {
        guard let url = URL(string: self.requestURLString) else {
            fatalError("Could not create a URL")
        }
        return URLRequest(url: url)
    }
}
