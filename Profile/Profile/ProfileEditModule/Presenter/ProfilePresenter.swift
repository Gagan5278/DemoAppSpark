//
//  ProfilePresenter.swift
//  Profile
//
//  Created Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//


import UIKit

class ProfilePresenter: ProfilePresenterProtocol {

    weak private var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    private let router: ProfileWireframeProtocol

    init(interface: ProfileViewProtocol, interactor: ProfileInteractorInputProtocol?, router: ProfileWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func fetchProfile() {
        view?.didStartLoadingIndicator()
        interactor?.fetchProfile()
    }
    
    func fetchRegion() {
        view?.didStartLoadingIndicator()
        interactor?.fetchRegion()
    }
    
    func showAlert(with title: String, message: String, view: ProfileViewProtocol, withCallback callBack: ((UIAlertAction) -> Void)?) {
        router.showAlert(with: title, message: message, view: view, withCallback: callBack)
    }
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func onRecieveprofile(item: ProfileModel) {
        view?.didRecieveProfile(item: item)
        view?.didStopLoadingIndicator()
    }
    
    func onReciveRegion(region: CityModel) {
        view?.didRecieveCity(item: region)
        view?.didStopLoadingIndicator()
    }
    
    func onRecieveError(error: APIError) {
        view?.didStopLoadingIndicator()
        view?.didFailWith(error: error)
    }
}
