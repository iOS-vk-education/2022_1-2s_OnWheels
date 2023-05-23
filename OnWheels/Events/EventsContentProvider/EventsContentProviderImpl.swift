//
//  EventsContentProviderImpl.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

final class EventsContentProviderImpl: EventsContentProvider {
    private var eventsInfo: [RaceListElement] = []
    
    func getEvent(with index: Int) -> RaceListElement {
        return eventsInfo[index]
    }
    
    func insertEvents(with events: [RaceListElement]) {
        eventsInfo.insert(contentsOf: events, at: 0)
    }
}
