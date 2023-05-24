//
//  UserInteractionNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

protocol UserInteractionNetworkManager {
    func postLike(with id: Int, completion: @escaping(_ error: String?)->())
    func postView(with id: Int, completion: @escaping(_ error: String?)->())
    func deleteLike(with id: Int, completion: @escaping(_ error: String?)->())
    func postMember(with id: Int, completion: @escaping(_ error: String?)->())
    func deleteMember(with id: Int, completion: @escaping(_ error: String?)->())
}


