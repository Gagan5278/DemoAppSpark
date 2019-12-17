//
//  ProfileInteractor.swift
//  Profile
//
//  Created Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class ProfileInteractor: ProfileInteractorInputProtocol {
    var remoteDataManager: RemoteDataManagerInputProtocol?
    weak var presenter: ProfileInteractorOutputProtocol?
    
    func fetchProfile() {
        remoteDataManager?.retrieveProfile()
    }
    
    func fetchRegion() {
        remoteDataManager?.retriveRegion()
    }
}

extension ProfileInteractor: RemoteDataManagerOutputProtocol {
    func onRecievedProfile(item: ProfileModel) {
        presenter?.onRecieveprofile(item: item)
    }
    
    func onRecievedCities(city: CityModel) {
        presenter?.onReciveRegion(region: city)
    }
    
    func onRecievedError(error: APIError) {
        presenter?.onRecieveError(error: error)
    }
}
