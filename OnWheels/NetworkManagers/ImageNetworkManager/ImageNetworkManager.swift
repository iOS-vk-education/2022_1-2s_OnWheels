//
//  ImageNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 21.05.2023.
//

import Foundation
final class ImageManagerImpl: NetworkManager, ImageManager {
    private let router: Router<ImageEndPoint>
    
    init(router: Router<ImageEndPoint>) {
        self.router = router
    }
    
    func postImage(with image: Data, completion: @escaping (ImageModel?, String?) -> ()) {
        router.request(.postImage(image: image)) { data, response, error in
            if error != nil {
                completion(nil, "Check network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        return completion(nil, NetworkResponse.noData.rawValue)
                    }
                    
                    do {
                        let apiResponse = try? JSONDecoder().decode(ImageModel.self, from: responseData)
                        return completion(apiResponse, nil)
                    }
                    catch {
                        return completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
