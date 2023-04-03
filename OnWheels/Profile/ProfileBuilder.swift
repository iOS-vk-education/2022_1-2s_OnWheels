//
// Created by Артём on 03.04.2023.
//

import UIKit

final class ProfileBuilderImpl: ProfileBuilder {
    let presenter: ProfilePresenter
    let viewController: ProfileViewControllerProtocol
    let router: ProfileRouter

    private init(viewController: ProfileViewControllerProtocol, presenter: ProfilePresenter,
                 router: ProfileRouter) {
        self.viewController = viewController
        self.presenter = presenter
        self.router = router
    }

    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> ProfileBuilder {
        let router = ProfileRouterImpl(window: window, navigationController: navigationController)

        let networkRouter = Router<UserEndPoint>()
        let userManager = UserNetworkManagerImpl(router: networkRouter)

        let presenter = ProfilePresenterImpl(router: router, service: userManager)
        let viewController = ProfileViewController(presenter: presenter)

        presenter.setVC(vc: viewController)
        router.setVC(vc: viewController)

        return ProfileBuilderImpl(viewController: viewController, presenter: presenter,
                router: router)
    }
}
