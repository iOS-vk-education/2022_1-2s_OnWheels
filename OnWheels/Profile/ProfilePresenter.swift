//
// Created by Артём on 03.04.2023.
//

import Foundation


class ProfilePresenterImpl: ProfilePresenter {
    private weak var vc: ProfileViewControllerProtocol?
    private var service: UserNetworkManager?
    private let router: ProfileRouter

    required init(router: ProfileRouter, service: UserNetworkManager) {
        self.router = router
        self.service = service
    }

    func setVC(vc: ProfileViewControllerProtocol) {
        self.vc = vc
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