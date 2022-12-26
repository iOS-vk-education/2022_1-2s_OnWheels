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
    
    private let eventsTableView = UITableView(frame: .zero, style: .plain)
        
    init(output: EventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        setupEventsTableView()
        setupNavigationBar()
    }
}

extension EventsViewController: EventsViewInput {
}

extension EventsViewController {
    private func setupLayout(){
        eventsTableView.pin
            .top()
            .marginTop(20)
            .left(12)
            .right(12)
            .bottom()
    }
    
    private func setupUI(){
        view.backgroundColor = R.color.background()
        view.addSubview(eventsTableView)
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
         NSAttributedString.Key.foregroundColor: R.color.mainBlue() ?? .black]
        self.title = R.string.localizable.events()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.setupLayout()
        cell.configure(mainText: R.string.localizable.eventName(),
                       dateText: R.string.localizable.eventDate(),
                       placeText: R.string.localizable.eventPlace(),
                       imageName: R.image.bikes2.name,
                       likeText: 20,
                       sharedText: 15,
                       watchedText: 30,
                       isLiked: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.rowDidSelect()
    }
}
