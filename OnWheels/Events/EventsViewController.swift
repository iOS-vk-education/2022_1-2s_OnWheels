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
        navBar.backgroundColor = R.color.background()
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
        self.title = R.string.localizable.events()
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
            .marginTop(20)
            .left(12)
            .right(12)
            .bottom()
    }
    
    private func setupUI(){
        view.backgroundColor = R.color.background()
        view.addSubview(eventsTableView)
        view.addSubview(navigationBar)
    }
    
    private func setupEventsTableView() {
        eventsTableView.showsVerticalScrollIndicator = false
        eventsTableView.separatorStyle = .none
        eventsTableView.backgroundColor = R.color.background()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(EventsInfoCell.self)
        eventsTableView.allowsSelection = true
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.setupLayout()
        cell.configure(mainText: R.string.localizable.eventName(),
                       dateText: R.string.localizable.eventDate(),
                       placeText: R.string.localizable.eventPlace(),
                       imageName: R.image.bikes2.name,
                       likeText: "20",
                       sharedText: "20",
                       watchedText: "20")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.rowDidSelect()
    }
    
    
}
