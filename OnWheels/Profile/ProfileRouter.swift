//
//  ProfileRouter.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import UIKit

final class ProfileRouter {
}

extension ProfileRouter: ProfileRouterInput {
    func deleteAccountButtonPressed() {
        print("delete")
    }
    
    func changeProfileInfoButtonTapped(){
        //здесь может появиться еще один экран
        print("change info")
    }
    
    func logoutButtonPressed(){
        print("logout")
    }
}
