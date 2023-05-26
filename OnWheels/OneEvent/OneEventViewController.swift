//
//  OneEventViewController.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import UIKit
import PinLayout
import CoreLocation

final class OneEventViewController: UIViewController, UIGestureRecognizerDelegate {
    private let output: OneEventViewOutput
    
    private let eventScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let eventContentView: OneEventContentView = {
        let event = OneEventContentView()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    private let backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(R.image.backButton(), for: .normal)
        back.tintColor = R.color.mainBlue()
        return back
    }()
    
    
    init(output: OneEventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()
        setupGestureRecognizer()
        output.loadInfo()
        setupLayout()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        let widthFrame = eventContentView.frame.width
        let height = Double((eventContentView.realHeight) * 1.2)
        eventScrollView.contentSize = CGSize(width: widthFrame, height: height)
    }
    
    @objc
    func backButtonTapped(){
        output.backButtonTapped()
    }
    
    @objc
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        output.backButtonTapped()
    }
}

extension OneEventViewController {
    private func setupLayout(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventScrollView)
        NSLayoutConstraint.activate([
            eventScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            eventScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            eventScrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        eventScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: eventScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: eventScrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: eventScrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: eventScrollView.heightAnchor, multiplier: 1.2)
        ])
        
        contentView.addSubview(eventContentView)
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        
        setupNavBar()
    }
    
    private func setupNavBar (){
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
    }
    
    private func setupGestureRecognizer(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupActions() {
        eventContentView.setParticipateAction {
            self.output.postMember()
        }
        
        eventContentView.unsetParticipateAction {
            self.output.removeMember()
        }
    }
}

extension OneEventViewController: OneEventViewInput {
    func addMember() {
        DispatchQueue.main.async {
            self.eventContentView.configureButton(isMember: true)
        }
    }
    
    func deleteMember() {
        DispatchQueue.main.async {
            self.eventContentView.configureButton(isMember: false)

        }
    }
    
    func setData(raceData: OneEvent) {
        DispatchQueue.main.async {
            self.eventContentView.configureViewWith(imageURL: raceData.imageId,
                                                    mainText: raceData.title,
                                                    placeName: raceData.placeName,
                                                    dateText: raceData.dateSubtitle,
                                                    additionalText: raceData.description,
                                                    longitude: raceData.longitude,
                                                    latitude: raceData.latitude,
                                                    tags: raceData.tags)
            self.eventContentView.configureButton(isMember: raceData.isMember)
        }
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: R.string.localizable.alertTitle(),
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertConfirmation(), style: .default))
        self.present(alert, animated: true)
    }
}
