//
//  Networking.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct NetworkCommunicator {
    /// URLSession Object
    var session: URLSession = URLSession(configuration: .default)
    ///CompletionHandler
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    //MARK:- Decode Obbject
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? Constants.User_Messages.serviceFailureErrorMessage))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch let error {
                        print(error)
                        completion(nil, .jsonConversionFailure(description: error.localizedDescription))
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
            else {
                do {
                    let item =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(item)
                }
                catch {
                    print(error)
                }
                completion(nil, .responseUnsuccessful(description: "status code = \(httpResponse.statusCode)"))
            }
        }
        return task
    }
    
    //MARK:- Make request and get Decodable Object
    func fetch<T: Decodable>(with router: APIRouter, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let request = router.asRequest()
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            ///change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    //MARK:- Fetch Swift Repo at a page
    func fetchUserChoice<T: Decodable>(value: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        self.fetch(with: APIRouter.choice, decode: { json -> T? in
            guard let resource = json as? T else { return nil }
            return resource
        }, completion: completionHandler)
    }
    
    //MARK:- Fetch Region list
    func fetchRegionList<T: Decodable>(value: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void){
        self.fetch(with: APIRouter.regoin, decode: { json -> T? in
            guard let resource = json as? T else { return nil }
            return resource
        }, completion: completionHandler)
    }
}
