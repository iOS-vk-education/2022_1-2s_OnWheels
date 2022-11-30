//
//  MyEventsHeader.swift
//  OnWheels
//
//  Created by Veronika on 30.11.2022.
//

import UIKit
import PinLayout


final class MyEventsHeader: UITableViewHeaderFooterView {
    var action:  ((Int) -> Void)?
    
    private let competeOrOrganizeSegmentedControl: UISegmentedControl = {
        let competeOrOrganize = UISegmentedControl(items: [R.string.localizable.organize(),
                                                           R.string.localizable.participate()])
        competeOrOrganize.tintColor = R.color.mainBlue()
        competeOrOrganize.selectedSegmentTintColor = R.color.mainOrange()
        competeOrOrganize.tintColor = R.color.cellColor()
        competeOrOrganize.selectedSegmentIndex = 0
        return competeOrOrganize
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
    }
    
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setAction(_ action: @escaping  ((Int) -> Void)) {
        self.action = action
    }
}

extension MyEventsHeader {
    func setupHeader(){
        self.addSubview(competeOrOrganizeSegmentedControl)
        competeOrOrganizeSegmentedControl.addTarget(self, action: #selector(changeSeg(_:)), for: .valueChanged)
    }
    
    func setupLayout(){
        competeOrOrganizeSegmentedControl.pin
            .top()
            .left()
            .right()
            .height(28)
    }
    
    @objc
    func changeSeg(_ sender: UISegmentedControl) {
        action?(sender.selectedSegmentIndex)
    }
}
