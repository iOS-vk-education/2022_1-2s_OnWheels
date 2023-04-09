//
//  RacesNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//

import Foundation
protocol RacesNetworkManager {
//    func getAllRaces(completion: @escaping(_ races: [Race]?, _ error: String?)->())
    func getListOfRaces(completion: @escaping(_ races: [RaceListElement]?, _ error: String?)->())
    func getRace(with id: Int, completion: @escaping(_ race: OneRace?, _ error: String?)->())
    func postLike(with id: Int, complition: @escaping(_ error: String?)->())
    func postView(with id: Int, complition: @escaping(_ error: String?)->())
    func putRace(with id: Int, and raceInfo: AddRace, completion: @escaping(_ error: String?)->())
}

final class RacesNetworkManagerImpl: NetworkManager, RacesNetworkManager {
    func putRace(with id: Int, and raceInfo: AddRace, completion: @escaping (String?) -> ()) {
        router.request(.putRace(raceId: id, raceInfo: raceInfo)) { data, response, error in
            if error != nil {
                completion("Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success :
                    guard let responseData = data else { return
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    func postLike(with id: Int, complition: @escaping (String?) -> ()) {
        router.request(.postLike(raceId: id)) { data, response, error in
            if error != nil {
                complition("Check netwotk connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        complition(NetworkResponse.noData.rawValue)
                        return
                    }
                    complition(nil)
                case .failure(let failure):
                    complition(failure)
                }
            }
        }
    }
    
    func postView(with id: Int, complition: @escaping (String?) -> ()) {
        router.request(.postView(raceId: id)) { data, response, error in
            if error != nil {
                complition("Check netwotk connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        complition(NetworkResponse.noData.rawValue)
                        return
                    }
                    complition(nil)
                case .failure(let failure):
                    complition(failure)
                }
            }
        }
    }
    
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
    }
    
    func getListOfRaces(completion: @escaping ([RaceListElement]?, String?) -> ()) {
        router.request(.getListOfRaces) { data, response, error in
            if error != nil {
                completion(nil, "Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try? JSONDecoder().decode(RaceList.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
        }
    }
    
    
    func getRace(with id: Int, completion: @escaping (OneRace?, String?) -> ()) {
        router.request(.getRace(raceId: id)) { data, response, error in
            if error != nil {
                completion(nil, "Check your connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try? JSONDecoder().decode(OneRace.self, from: responseData)
                        completion(apiResponse, nil)
                    }
                    catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
        }
    }
}
