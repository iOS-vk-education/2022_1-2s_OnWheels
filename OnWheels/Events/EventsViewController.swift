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
    
    private let refreshControl = UIRefreshControl()
    
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
        setupEventsTableView()
        setupNavigationBar()
        setupActions()
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.showLoaderView()
        output.didLoadRaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
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
        self.tabBarController?.tabBar.backgroundColor = R.color.cellColor()
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
    
    func setupRefreshControl() {
        refreshControl.tintColor = R.color.mainBlue()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        eventsTableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh() {
        output.didLoadRaces()
    }
}

extension EventsViewController: EventsViewInput {
    func showLoaderView() {
        eventsTableView.isHidden = true
        self.showLoader(animationName: R.file.loaderAnimationJson.name)
    }
    
    func hideLoaderView() {
        self.hideLoader()
        eventsTableView.isHidden = false
    }
    
    func update(withRaces races: [RaceInfo]) {
        refreshControl.endRefreshing()
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
