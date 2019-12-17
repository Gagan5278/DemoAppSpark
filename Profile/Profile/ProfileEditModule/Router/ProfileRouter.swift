//
//  ProfileRouter.swift
//  Profile
//
//  Created Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//


import UIKit

class ProfileRouter: ProfileWireframeProtocol {
    
    weak var viewController: UIViewController?

    
    static func createProfileViewModule() -> UIViewController {
        let rootNavigationController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "rootViewController")
        if let view = rootNavigationController.children.first as? ProfileViewController {
            let interactor: ProfileInteractorInputProtocol & RemoteDataManagerOutputProtocol = ProfileInteractor()
            let remoteDataManager: RemoteDataManagerInputProtocol = RemoteDataManager()
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            let router = ProfileRouter()
            let presenter = ProfilePresenter(interface: view, interactor: interactor, router: router)
            view.presenter = presenter
            interactor.presenter = presenter
            router.viewController = view
            return rootNavigationController
        }
        return UIViewController()
    }
    
    func showAlert(with title: String, message: String, view: ProfileViewProtocol, withCallback callBack: ((UIAlertAction) -> Void)?) {
        if let viewController = view as? UIViewController {
             CustomAlert.showUserAlert(with: title, message: message, buttonTitle: "OK", onViewController: viewController, withCallback: callBack)
         }
    }

}
