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
        
        setupMap()
    }
    
    func setupMap(){
        let point = MKPointAnnotation()
        point.title = R.string.localizable.eventPlace()
        point.coordinate = CLLocationCoordinate2D(latitude: 54.7430, longitude: 55.96779)
        let center = point.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.addAnnotation(point)
        mapView.region = region
    }
    
    func cofigureMap(latitude: Double, longitude: Double) {
        let point = MKPointAnnotation()
        do {
            point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let center = point.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.addAnnotation(point)
            mapView.region = region
        } catch {
            eventPlaceInfoLabel.text = "Уточните у организатора"
        }

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
