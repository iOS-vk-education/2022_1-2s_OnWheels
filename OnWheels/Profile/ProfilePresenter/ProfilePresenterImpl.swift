//
// Created by Артём on 03.04.2023.
//

import Foundation


final class ProfilePresenterImpl: ProfilePresenter {
    private weak var viewController: ProfileView?
    private var userNetworkManager: UserNetworkManager?
    private let router: ProfileRouter
    
    init(router: ProfileRouter, userNetworkManager: UserNetworkManager) {
        self.router = router
        self.userNetworkManager = userNetworkManager
    }
    
    func setViewController(viewController: ProfileView) {
        self.viewController = viewController
    }
    
    func update() {
        userNetworkManager?.currentUserInfo { user, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let user = user {
                    let userInfo: ProfileUserInfo = ProfileUserInfo(firstname: user.firstname, surname: user.lastname, city: user.city, email: user.email, birthday: user.birthday, sex: user.sex)
                    self.viewController?.setUserInfo(user: userInfo)
                }
            }
        }
    }
    
    func logout() {
        userNetworkManager?.logout {
            self.router.switchToAuth()
        }
    }
    
    func deleteAccount() {
        userNetworkManager?.deleteUser {
            self.router.switchToAuth()
        }
    }
    
    // также тут могло бы быть:
    //func navigateToSettings() {
    //        router.navigateToSettings()
    //    }
}
