//
//  EventsContentProvider.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

protocol EventsContentProvider {
    func getEvent(with index: Int) -> RaceListElement
    func insertEvents(with events: [RaceListElement])
}
