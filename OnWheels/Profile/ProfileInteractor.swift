//
//  ProfileInteractor.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import Foundation

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(userManager: UserNetworkManager) {
        self.userManager = userManager
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func loadUserInfo(){
        self.userManager.currentUserInfo { user, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let user = user {
                    self.output?.setUserData(user: user)
                }
            }
        }
    }
}
