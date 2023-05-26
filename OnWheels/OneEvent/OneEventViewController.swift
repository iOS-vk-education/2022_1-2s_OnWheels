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

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        let widthFrame = eventContentView.frame.width
        let height = eventContentView.bounds.height
        eventScrollView.contentSize = CGSize(width: widthFrame,
                                             height: height)
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
        eventContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventScrollView)
        NSLayoutConstraint.activate([
            eventScrollView.topAnchor.constraint(equalTo: eventImage.bottomAnchor),
            eventScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        eventScrollView.addSubview(eventContentView)
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: eventScrollView.topAnchor, constant: 16),
            eventContentView.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 20),
            eventScrollView.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor, constant: -20),
            eventContentView.bottomAnchor.constraint(equalTo: eventScrollView.bottomAnchor),
            eventContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventContentView.heightAnchor.constraint(equalTo: eventScrollView.heightAnchor, multiplier: 1.1)
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
}

extension OneEventViewController: OneEventViewInput {
    func setData(raceData: OneRace){
        print(raceData)
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter1.locale = Locale(identifier: "en_US_POSIX")
        var dateString = ""
          
        if let date2 = formatter1.date(from: raceData.date.from) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "EEEE, MMM d, yyyy"
            formatter2.locale = Locale(identifier: "en_US_POSIX")

            dateString = formatter2.string(from: date2)
        }
        
        let location = CLLocation(latitude: raceData.location.latitude, longitude: raceData.location.longitude)
        
        var cityLoc = ""
        var countryLoc = ""
        
        location.fetchCityAndCountry { [weak self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            cityLoc = city // Rio de Janeiro, Brazil
            DispatchQueue.main.async {
                self?.configureViewWith(name: raceData.name,
                                  description: raceData.oneRaceDescription,
                                  place: cityLoc, date: dateString)
                self?.mapView.cofigureMap(latitude: raceData.location.latitude, longitude: raceData.location.longitude, name: cityLoc)
            }
        }
    }
}
