//
//  ViewController.swift
//  OnWheels
//
//  Created by Илья on 10/23/22.
//

import UIKit
import PinLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        self.loadTabBar()
        
    }

//    Create and present TabBar
    func loadTabBar() {
        let tabBarVC = UITabBarController()
        
        let eventVC = eventVC()
        let mainVC = mainVC()
        let profileVC = profileVC()
        
        eventVC.title = "Мероприятия"
        mainVC.title = "Главный экран"
        profileVC.title = "Профиль"
        
        tabBarVC.setViewControllers([eventVC, mainVC, profileVC], animated: false)
        tabBarVC.tabBar.backgroundColor = UIColor(named: "OW.White")
        tabBarVC.tabBar.items?[0].image = UIImage(named: "TabBar.Bycicle.Tapped")
        tabBarVC.tabBar.items?[1].image = UIImage(named: "TabBar.Main.nTapped")
        tabBarVC.tabBar.items?[2].image = UIImage(named: "TabBar.Profile.nTapped")
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: false)
    }
}

class eventVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class mainVC: UIViewController {
    private let tableViewMain = UITableView()
    
    init() {
        tableViewMain.backgroundColor = UIColor(named: "OW.Gray")
        tableViewMain.pin.all(pin.safeArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    
}

class profileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}
