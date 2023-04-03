//
// Created by Артём on 03.04.2023.
//

import UIKit

protocol ProfilePresenter {
    init(router: ProfileRouter, service: UserNetworkManager)
    func update()
    func setVC(vc: ProfileViewControllerProtocol)

    // MARK: - связка с сервисом, функции для вьюшки
    func logout()
    func deleteAccount()
}

protocol ProfileRouter {
    init(window: UIWindow, navigationController: UINavigationController)
    func start()
    func setVC(vc: UIViewController)
}

protocol ProfileViewControllerProtocol: AnyObject {
    func setUserInfo(user: CurrentUser)
}

protocol ProfileBuilder {
    var presenter: ProfilePresenter { get }
    var viewController: ProfileViewControllerProtocol { get }
    var router: ProfileRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> ProfileBuilder
}
