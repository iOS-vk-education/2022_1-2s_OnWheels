//
// Created by Артём on 03.04.2023.
//

import Foundation


class ProfilePresenterImpl: ProfilePresenter {
    private weak var viewController: ProfileViewController?
    private var userNetworkManager: UserNetworkManager?
    private let router: ProfileRouter

    required init(router: ProfileRouter, userNetworkManager: UserNetworkManager) {
        self.router = router
        self.userNetworkManager = userNetworkManager
    }

    func setViewController(viewController: ProfileViewController) {
        self.viewController = viewController
    }

    func update() {
        // call to viewController to update labels
        <#code#>
    }

    func logout() {
        // call to service
        <#code#>
    }

    func deleteAccount() {
        // call to service
        <#code#>
    }

    // также тут могло бы быть:
    //func navigateToSettings() {
    //        router.navigateToSettings()
    //    }

}
