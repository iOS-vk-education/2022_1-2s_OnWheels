//
// Created by Артём on 03.04.2023.
//

import UIKit


protocol ProfileBuilder {
    var presenter: ProfilePresenter { get }
    var view: ProfileView { get }
    var router: ProfileRouter { get }
    static func assemble(window: UIWindow, navigationController: UINavigationController) -> ProfileBuilder
}


final class ProfileBuilderImpl: ProfileBuilder {
    let presenter: ProfilePresenter
    let view: ProfileView
    let router: ProfileRouter

    private init(view: ProfileView, presenter: ProfilePresenter, router: ProfileRouter) {
        self.view = view
        self.presenter = presenter
        self.router = router
    }

    static func assemble(window: UIWindow, navigationController: UINavigationController) -> ProfileBuilder {
        let router = ProfileRouterImpl(window: window, navigationController: navigationController)

        let networkRouter = Router<UserEndPoint>()
        let userManager = UserNetworkManagerImpl(router: networkRouter)

        let presenter = ProfilePresenterImpl(router: router, userNetworkManager: userManager)
        let view = ProfileViewController(presenter: presenter)

        presenter.setViewController(viewController: view)
        router.setViewController(viewController: view)

        return ProfileBuilderImpl(view: view, presenter: presenter,
                router: router)
    }
}
