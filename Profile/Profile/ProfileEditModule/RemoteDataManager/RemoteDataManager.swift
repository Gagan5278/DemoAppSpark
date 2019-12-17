//
//  RemoteDataManager.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
class RemoteDataManager: RemoteDataManagerInputProtocol {
    let network = NetworkCommunicator()
    var remoteRequestHandler: RemoteDataManagerOutputProtocol?

    //MARK:- fetch profile
    func retrieveProfile() {
        network.fetchUserChoice(value: ProfileModel.self) {
          self.handleResult($0)
        }
    }
    
    //MARK:- Fetch Region
    func retriveRegion() {
        network.fetchRegionList(value: CityModel.self) {
          self.handleResult($0)
        }
    }
    
    private func handleResult<T>(_ result: Result<T, APIError>) {
        switch result {
        case .success(let value):
            if let profile = value as? ProfileModel {
                remoteRequestHandler?.onRecievedProfile(item: profile)
            }
            else {
                remoteRequestHandler?.onRecievedCities(city: value as! CityModel)
            }
        case .failure(let err):
            remoteRequestHandler?.onRecievedError(error: err)
        }
    }

}
