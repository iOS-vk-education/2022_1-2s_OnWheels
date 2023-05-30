//
//  CustomTabBar.swift
//  OnWheels
//
//  Created by Veronika on 27.05.2023.
//

import UIKit

final class CustomTabBar: UITabBarController {
    var window: UIWindow

//    var customTabBar = CustomTabBarView()
//    override var tabBar: UITabBar {
//        return customTabBar
//    }

    init(window: UIWindow) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBarView(frame: tabBar.frame), forKey: "tabBar") // FIXME: костыль, но единственный рабочий?
        delegate = self
        tabBar.isTranslucent = false
        configureTabBar()
    }
}

protocol TabBarReselectHandling {
    func handleReselect()
}

extension CustomTabBar: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedViewController === viewController {
            if let handler = (viewController as? UINavigationController)?.viewControllers[0] as? TabBarReselectHandling {
                handler.handleReselect()
            } else {
                print("could not convert handler, NOT OK")
            }
        } else {
            print("not matching selected, OK")
        }
        return true
    }
}

private extension CustomTabBar {
    func configureTabBar() {
        let eventsViewController = setupEvents()
        eventsViewController.tabBarItem = UITabBarItem(title: R.string.localizable.events(), image: R.image.events(), tag: 0)
        let eventsNavigationController = UINavigationController(rootViewController: eventsViewController)

        var profileNavigationController = UINavigationController()
        let profileViewController = setupProfile(with: profileNavigationController)
        profileViewController.tabBarItem = UITabBarItem(title: R.string.localizable.profile(), image: R.image.profile(), tag: 2)
        profileNavigationController = UINavigationController(rootViewController: profileViewController)

        viewControllers = [eventsNavigationController, profileNavigationController]

        setupMiddleButton()
        setupUI()
    }

    private func setupEvents() -> UIViewController {
        let eventsContext = EventsContext(window: window)
        let eventsContainer = EventsContainer.assemble(with: eventsContext)
        return eventsContainer.viewController
    }

    private func setupAddEvent() -> UIViewController {
        let addEventContext = AddEventContext(moduleOutput: nil)
        let addEventContainer = AddEventContainer.assemble(with: addEventContext)
        return addEventContainer.viewController
    }

    private func setupProfile(with navController: UINavigationController) -> UIViewController {
        let profileContainer = ProfileBuilderImpl.assemble(window: window, navigationController: navController)
        return profileContainer.view
    }

    private func setupUI() {
        let positionX: CGFloat = 10.0
        tabBar.itemWidth = (tabBar.bounds.width - positionX * 2)
        tabBar.itemPositioning = .centered
        tabBar.tintColor = R.color.mainOrange()
        tabBar.unselectedItemTintColor = R.color.mainBlue()
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = R.color.cellColor()


        self.tabBarController?.tabBar.standardAppearance = appearance
        self.tabBarController?.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }

    func setupMiddleButton() {
        let centerButton = TabBarCenterButton(frame: CGRect(x: 0, y: 0, width: 64, height: 80))
        centerButton.center = CGPoint(x: self.tabBar.center.x, y: self.tabBar.bounds.height / 2 - 18)
        self.tabBar.addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }

    @objc
    func buttonAction() {
        let addRaceViewController = setupAddEvent()
        present(addRaceViewController, animated: true)
    }
}


final class CustomTabBarView: UITabBar {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event) // 1
        if pointIsInside == false { // 2
            for subview in subviews { // 2.1
                let pointInSubview = subview.convert(point, from: self) // 2.2
                if subview.point(inside: pointInSubview, with: event) { // 2.3
                    return true // 2.3.1
                }
            }
        }
        return pointIsInside // 3
    }

    override func addSubview(_ view: UIView) {
        super.addSubview(view)
    }
}