//
//  EventsContentProvider.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

protocol EventsContentProvider {
    func getEvent(with index: Int) -> RaceInfo
    func insertEvents(with events: [RaceInfo])
}
