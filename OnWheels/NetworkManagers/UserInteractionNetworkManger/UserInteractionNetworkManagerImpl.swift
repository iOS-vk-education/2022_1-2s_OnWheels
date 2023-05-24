//
//  UserInteractionNetworkManagerImpl.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

final class UserInteractionNetworkManagerImpl: NetworkManager, UserInteractionNetworkManager {
        private let router: Router<UserInteractionEndPoint>

    init(router: Router<UserInteractionEndPoint>) {
        self.router = router
    }
    
    func postLike(with id: Int, completion: @escaping (String?) -> ()) {
        router.request(.postLike(raceId: id)) { data, response, error in
            if error != nil {
                completion("Check netwotk connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(nil)
                case .failure(let failure):
                    completion(failure)
                }
            }
        }
    }
    
    func deleteLike(with id: Int, completion: @escaping (String?) -> ()) {
        router.request(.deleteLike(raceId: id)) { data, response, error in
            if error != nil {
                completion("Check netwotk connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(nil)
                case .failure(let failure):
                    completion(failure)
                }
            }
        }
    }
    
    func postView(with id: Int, completion: @escaping (String?) -> ()) {
        router.request(.postView(raceId: id)) { data, response, error in
            if error != nil {
                completion("Check netwotk connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(nil)
                case .failure(let failure):
                    completion(failure)
                }
            }
        }
    }
    
    

}
