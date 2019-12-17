//
//  ProfileProtocols.swift
//  Profile
//
//  Created Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
//MARK: Wireframe -
protocol ProfileWireframeProtocol: class {
    //alert message
    func showAlert(with title: String, message: String, view:ProfileViewProtocol, withCallback callBack :((UIAlertAction) -> Void)? )
}
//MARK: Presenter -
protocol ProfilePresenterProtocol: class {

    var interactor: ProfileInteractorInputProtocol? { get set }
    //fetch items
    func fetchProfile()
    //fetch region
    func fetchRegion()
    //alert message
    func showAlert(with title: String, message: String, view:ProfileViewProtocol, withCallback callBack :((UIAlertAction) -> Void)? )

}

//MARK: Interactor -
protocol ProfileInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onRecieveprofile(item: ProfileModel)
    func onReciveRegion(region: CityModel)
    func onRecieveError(error: APIError)

}

protocol ProfileInteractorInputProtocol: class {

    var presenter: ProfileInteractorOutputProtocol?  { get set }
    var remoteDataManager: RemoteDataManagerInputProtocol? {get set}
    /* Presenter -> Interactor */
     func fetchProfile()
     func fetchRegion()
}

//MARK: RemoteDataManager -
protocol RemoteDataManagerOutputProtocol {
    /* Remotedatamanager -> Interactor */
    func onRecievedProfile(item: ProfileModel)
    func onRecievedCities(city: CityModel)
    func onRecievedError(error: APIError)
}

protocol RemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RemoteDataManagerOutputProtocol? {get set}
    /* Interactor -> Remotedatamanager */
    func retrieveProfile()
    func retriveRegion()
}

//MARK: View -
protocol ProfileViewProtocol: class {

    var presenter: ProfilePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didRecieveProfile(item: ProfileModel)
    func didRecieveCity(item: CityModel)
    func didFailWith(error: APIError)
    func didStartLoadingIndicator()
    func didStopLoadingIndicator()

}
