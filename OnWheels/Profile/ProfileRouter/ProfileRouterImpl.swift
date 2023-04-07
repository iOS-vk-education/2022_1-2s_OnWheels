//
// Created by Артём on 03.04.2023.
//

import UIKit


final class ProfileRouterImpl: ProfileRouter {
    private let window: UIWindow
    var navigationController: UINavigationController
    private weak var viewController: UIViewController?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        // добавляет вьюконтроллер в стек навигейшн контроллера
        if let viewController = viewController {
            navigationController.pushViewController(viewController, animated: true)
        }
        window.makeKeyAndVisible()
    }

    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }

    // что тут еще может быть:
    //// MARK: - flow changer
    //
    //    func switchToMainFlow() {
    //        print("change flow")
    //        flowAfterFirstAuth?.start()
    //    }
    //
    //// MARK: - navigation
    //    func navigateToProfileDetails() {
    //        print("navigate")
    //        let placeholder = UIViewController()
    //        placeholder.view.backgroundColor = .darkGray
    //        let placeholderLabel = UILabel()
    //        placeholderLabel.text = R.string.localizable.your_profile_button_title()
    //        placeholder.view.addSubview(placeholderLabel)
    //        navigationController.pushViewController(placeholder, animated: true)
    //        //        let child = DetailProfileBuilder.assemble(window: window, navigationController: navigationController)
    //        //        childCoordinators.append(child.coordinator)
    //        //        child.coordinator.parentCoordinator = self
    //        //        child.coordinator.start()
    //    }
}
