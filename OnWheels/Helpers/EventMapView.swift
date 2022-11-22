//
//  EventMapView.swift
//  OnWheels
//
//  Created by Veronika on 22.11.2022.
//

import UIKit
import PinLayout
import MapKit

final class EventMapView: UIView {
    
    private let eventPlaceLabel: UILabel = {
        let eventPlace = UILabel()
        eventPlace.font = UIFont.systemFont(ofSize: 16, weight: .light)
        eventPlace.textColor = R.color.mainBlue()
        eventPlace.text = R.string.localizable.mapEventPlace()
        return eventPlace
    }()
    
    private let eventPlaceInfoLabel: UILabel = {
        let eventPlaceInfo = UILabel()
        eventPlaceInfo.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        eventPlaceInfo.textColor = R.color.mainOrange()
        eventPlaceInfo.text = R.string.localizable.eventPlace()
        return eventPlaceInfo
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .tertiarySystemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout(){
        self.addSubview(eventPlaceLabel)
        eventPlaceLabel.pin
            .top(Constants.EventPlaceLabel.topMargin)
            .left(Constants.EventPlaceLabel.leftMargin)
            .height(Constants.EventPlaceLabel.height)
            .right()
        
        self.addSubview(eventPlaceInfoLabel)
        eventPlaceInfoLabel.pin
            .top(to: eventPlaceLabel.edge.bottom)
            .marginTop(Constants.EventPlaceInfoLabel.topMargin)
            .left(Constants.EventPlaceInfoLabel.leftMargin)
            .right()
            .height(Constants.EventPlaceInfoLabel.height)
        
        self.addSubview(mapView)
        mapView.pin
            .top(to: eventPlaceInfoLabel.edge.bottom)
            .marginTop(Constants.MapView.marginTop)
            .left()
            .right()
            .bottom(to: self.edge.bottom)
    }
    
    struct Constants {
        struct EventPlaceLabel {
            static let topMargin: CGFloat = 16
            static let leftMargin: CGFloat = 20
            static let height: CGFloat = 20
        }
        struct EventPlaceInfoLabel {
            static let topMargin: CGFloat = 4
            static let leftMargin: CGFloat = 20
            static let height: CGFloat = 20
        }
        struct MapView {
            static let marginTop: CGFloat = 16
        }
    }
}
