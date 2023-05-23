//
//  ImageNetworkManagerImpl.swift
//  OnWheels
//
//  Created by Veronika on 21.05.2023.
//

import Foundation
protocol ImageManager {
    func postImage(with image: Data, completion: @escaping(_ imageData: ImageModel?, _ error: String?) -> ())
}


