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
    var raceDataList: RaceList = []
    
    private let eventsTableView = UITableView(frame: .zero, style: .plain)
    private lazy var eventsTableAdapter = EventsTableAdapter(tableView: eventsTableView)
        
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
        setupActions()
        output.didLoadRaces()
    }
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
        eventsTableView.delegate = eventsTableAdapter
        eventsTableView.register(EventsInfoCell.self)
        eventsTableView.allowsSelection = true
    }
    
    func setupActions() {
        eventsTableAdapter.setOpenAction { [weak self] index in
            self?.output.rowDidSelect(at: index)
            self?.output.didSetVeiw(at: index)
        }
        
        eventsTableAdapter.setLikeAction { [weak self] index in
            self?.output.didSetLike(for: index)
        }
        
        eventsTableAdapter.setDislikeAction { [weak self] index in
            self?.output.didSetDislike(for: index)
        }
    }
}

extension EventsViewController: EventsViewInput {
    func showLoaderView() {
        eventsTableView.isHidden = true
        self.showLoader()
    }
    
    func hideLoaderView() {
        self.hideLoader()
        eventsTableView.isHidden = false
    }
    
    func update(withRaces races: [RaceInfo]) {
        eventsTableAdapter.update(with: races)
    }
    
    func setLike(raceId: Int) {
        eventsTableAdapter.updateWithLike(withIndex: raceId)
    }
    
    func setView(raceId: Int) {
        eventsTableAdapter.updateWatchers(withIndex: raceId)
    }
    
    func setDislike(raceId: Int) {
        eventsTableAdapter.updateWithDislike(withIndex: raceId)
    }
    
    func addWatcher(raceId: Int) {
        eventsTableAdapter.updateWatchers(withIndex: raceId)
    }
}
