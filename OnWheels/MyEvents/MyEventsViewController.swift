//
//  MyEventsViewController.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//


import UIKit
import PinLayout

final class MyEventsViewController: UIViewController {
    private let output: MyEventsViewOutput
    
    private let myEventsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.isUserInteractionEnabled = true
        return table
    }()
    
    private let jumpButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(R.image.jumpButton(), for: .normal)
        back.tintColor = R.color.mainBlue()
        return back
    }()
    
    private let myEventsHeaderView = MyEventsHeader()
    
    init(output: MyEventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.myEvents()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        setupMyEventsTableView()
        setupNavigationBar()
    }
}

extension MyEventsViewController: MyEventsViewInput {
}

private extension MyEventsViewController {
    
    func setupLayout(){
        myEventsTableView.pin
            .top()
            .marginTop(Constants.MyEventsTableView.marginTop)
            .left(Constants.MyEventsTableView.left)
            .right(Constants.MyEventsTableView.right)
            .bottom()
    }
    
    func setupUI(){
        view.backgroundColor = .backgroundColor
        view.addSubview(myEventsTableView)
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
         NSAttributedString.Key.foregroundColor: R.color.mainBlue() ?? .black]
        self.title = R.string.localizable.myEvents()
    }
    
    private func setupNavBar (){
        jumpButton.addTarget(self, action: #selector(jumpButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: jumpButton)
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
    }
    
    
    func setupMyEventsTableView() {
        myEventsTableView.separatorStyle = .none
        myEventsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        myEventsTableView.showsVerticalScrollIndicator = false
        myEventsTableView.backgroundColor = .backgroundColor
        myEventsTableView.delegate = self
        myEventsTableView.dataSource = self
        myEventsTableView.register(EventsInfoCell.self)
        myEventsTableView.allowsSelection = true
        myEventsTableView.tableHeaderView = myEventsHeaderView
        myEventsTableView.tableHeaderView?.frame.size = CGSize(width: myEventsTableView.frame.width,
                                                               height: 36)
        setupHeaderAction()
    }
    
    func setupHeaderAction(){
        myEventsHeaderView.setAction { sender in
            print("Selected Segment Index is : \(sender)")
        }
    }
    
    struct Constants {
        struct MyEventsTableView {
            static let marginTop: CGFloat = 32
            static let left: CGFloat = 12
            static let right: CGFloat = 12
        }
    }
}

extension MyEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.setupLayout()
        cell.configure(indexPath: indexPath.row,
                       mainText: R.string.localizable.eventName(),
                       dateText: R.string.localizable.eventDate(),
                       placeText: R.string.localizable.eventPlace(),
                       imageName: R.image.durtbike.name,
                       likeText: 18,
                       sharedText: 1,
                       watchedText: 2,
                       isLiked: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    @objc
    func jumpButtonTapped(){
        output.jumpButtonTapped()
    }
    
    @objc
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        output.jumpButtonTapped()
    }
}

