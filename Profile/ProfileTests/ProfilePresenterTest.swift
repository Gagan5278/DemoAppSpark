//
//  ProfileTests.swift
//  ProfileTests
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import Profile

class ProfilePresenterTest: XCTestCase {
    var listPresenter: ProfilePresenter!
    var mockView: MockView!
    var interactor: MockListIteractor!
    var router: MockRouter!
    var dataManager: MockDataManager!
    override func setUp() {
        presenterSetUp()
    }

    override func tearDown() {
        listPresenter = nil
        dataManager = nil
        router = nil
        interactor = nil
        mockView = nil
    }

    fileprivate func presenterSetUp() {
        mockView = MockView()
        interactor = MockListIteractor()
        router = MockRouter()
        dataManager = MockDataManager()
        interactor.remoteDataManager = dataManager
        dataManager.remoteRequestHandler = interactor
        listPresenter = ProfilePresenter(interface: mockView, interactor: interactor, router: router)
    }
    
    //MARK:- Test
    func testIsLoadingIndicator() {
        interactor.fail = true
        listPresenter.fetchProfile()
        XCTAssertTrue(mockView.isLoading)
    }
    
    //MARK:- Test Stop Loading
    func testStopLoadingIndicator() {
      interactor.presenter = listPresenter
      listPresenter.fetchProfile()
      XCTAssertTrue(!mockView.isLoading)
    }
    
    //MARK:- Test Error in fetching list
    func testFetchingError() {
        interactor.presenter = listPresenter
        interactor.fail = true
        listPresenter.fetchProfile()
        XCTAssertTrue(mockView.isErrorFound)
    }
    
    func testMockRouterShowAlert(){
         router.showAlert(with: "", message: "", view: mockView!, withCallback: nil)
         XCTAssertTrue(router.isDisplayingAlert)
    }
    

    
    func testPresenterShowAlert() {
        interactor.presenter = listPresenter
        interactor.fail = true
        listPresenter.showAlert(with: "", message: "", view: mockView!, withCallback: nil)
        XCTAssertTrue(router.isDisplayingAlert)
    }
    
    
    //MARK:- Test Data Manager On Error
    func testDataMamangerOnError()
    {
        interactor.presenter = listPresenter
        dataManager.isError = true
        interactor.remoteDataManager?.retrieveProfile()
        XCTAssertTrue(interactor.isErrorFoundOnRequest)
    }
    
    //MARK:- Test Data Mamager on Sucesss
    func testDataMamangerOnSucesss()
    {
        interactor.presenter = listPresenter
        dataManager.isError = true
        interactor.remoteDataManager?.retriveRegion()
        XCTAssertTrue(interactor.isErrorFoundOnRequest)
    }
}


//MARK:- Create a Mock Router
class MockRouter: ProfileWireframeProtocol {
    var isPushed: Bool = false

    
    var isDisplayingAlert: Bool = false
    func showAlert(with title: String, message: String, view: ProfileViewProtocol, withCallback callBack: ((UIAlertAction) -> Void)?) {
        isDisplayingAlert = true
    }
}

//MARK:- Mock Interactor
class MockListIteractor: ProfileInteractorInputProtocol {
        var presenter: ProfileInteractorOutputProtocol?
    var fail = false
    var isErrorFoundOnRequest: Bool = false
    var remoteDataManager: RemoteDataManagerInputProtocol?
    
    func fetchProfile() {
                if fail {
            presenter?.onRecieveError(error: APIError.jsonParsingFailure)
        }
        else {
            presenter?.onRecieveprofile(item: FakeProvider.getProfileFakeModel()!)
        }
    }
    
    func fetchRegion() {
                if fail {
            presenter?.onRecieveError(error: APIError.jsonParsingFailure)
        }
        else {
            presenter?.onReciveRegion(region: FakeProvider.getFakeCityModel()!)
        }
    }
}

extension MockListIteractor: RemoteDataManagerOutputProtocol {
    func onRecievedProfile(item: ProfileModel) {
        isErrorFoundOnRequest = false
    }
    
    func onRecievedCities(city: CityModel) {
        isErrorFoundOnRequest = false
    }

    func onRecievedError(error: APIError) {
        isErrorFoundOnRequest = true
    }
}

//MARK:- Mock View
class MockView: ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?
    var isLoading: Bool = false
    var isErrorFound: Bool = false

    func didRecieveProfile(item: ProfileModel) {
        isErrorFound = false

    }
    
    func didRecieveCity(item: CityModel) {
        isErrorFound = false
    }

    
    func didFailWith(error: APIError) {
        isErrorFound = true
    }
    
    func didStartLoadingIndicator() {
        isLoading = true
    }
    
    func didStopLoadingIndicator() {
        isLoading = false
    }

}

//MARK:- Mock DataManager
class MockDataManager: RemoteDataManagerInputProtocol {
    var remoteRequestHandler: RemoteDataManagerOutputProtocol?
    var isError: Bool = false
    func retrieveProfile() {
                if isError {
            remoteRequestHandler?.onRecievedError(error: APIError.invalidData)
        }
        else {
            remoteRequestHandler?.onRecievedProfile(item: FakeProvider.getProfileFakeModel()!)
        }
    }
    
    func retriveRegion() {
                if isError {
            remoteRequestHandler?.onRecievedError(error: APIError.invalidData)
        }
        else {
            remoteRequestHandler?.onRecievedCities(city: FakeProvider.getFakeCityModel()!)
        }
    }
}

