//
//  EventsViewController.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import UIKit
import PinLayout

final class EventsViewController: UIViewController {
	private let output: EventsViewOutput
    
    private let navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainBlueColor as Any]
        return navBar
    }()
    
    private let eventsTableView = UITableView(frame: .zero, style: .plain)
    

    init(output: EventsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        self.title = R.string.localizable.eventsViewTitle()
        setupUI()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        setupEventsTableView()
    }
}

extension EventsViewController: EventsViewInput {
}

extension EventsViewController {
    private func setupLayout(){
        
        navigationBar.pin
            .top()
            .right()
            .left()
        
        eventsTableView.pin
            .top(to: navigationBar.edge.bottom)
            .left()
            .right()
            .bottom()
    }
    
    private func setupUI(){
        view.backgroundColor = .backgroundColor
        view.addSubview(eventsTableView)
        view.addSubview(navigationBar)
    }
    
    private func setupEventsTableView() {
        eventsTableView.separatorStyle = .none
        eventsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        eventsTableView.showsVerticalScrollIndicator = false
        eventsTableView.backgroundColor = .backgroundColor
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(EventsInfoCell.self)
        eventsTableView.allowsSelection = false
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
        
        switch indexPath.row {
            case 1:
            cell.configure(mainText: "Чемпионат России", dateText: "7 янв. - 10 янв.", placeText: "Респ. Башкортостан, Уфа", imageName: "durtbike", likeText: "20", sharedText: "20", watchedText: "20")
            case 0:
                cell.configure(mainText: "Чемпионат Башкирии", dateText: "8 янв. - 11 янв.", placeText: "Респ. Башкортостан, Уфа", imageName: "bikes2", likeText: "19", sharedText: "0", watchedText: "5")
                
            default:
                cell.configure(mainText: "Base", dateText: "Base", placeText: "Base", imageName: "eventImageBase", likeText: "0", sharedText: "0", watchedText: "0")
        }
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.5
    }
    
    
}
