//
//  CustomTabBar.swift
//  OnWheels
//
//  Created by Veronika on 27.05.2023.
//

import UIKit

final class CustomTabBar: UITabBarController {
    var window: UIWindow
    var navController: UINavigationController
    
    init (window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navController = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        configureTabBar()
    }
}

private extension CustomTabBar {
    func configureTabBar() {
        let eventsViewController = setupEvents()
        eventsViewController.tabBarItem = UITabBarItem(title: R.string.localizable.events(), image: R.image.events(), tag: 0)
        let eventsNavigationController = UINavigationController(rootViewController: eventsViewController)
        
        let profileViewController = setupProfile()
        profileViewController.tabBarItem = UITabBarItem(title: R.string.localizable.profile(), image: R.image.profile(), tag: 2)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
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
    
    private func setupProfile() -> UIViewController {
        let profileContainer = ProfileBuilderImpl.assemble(window: window,
                                                           navigationController: navController)
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
        let newAddRaceViewController = setupAddEvent()
        present(newAddRaceViewController, animated: true)
    }
}
