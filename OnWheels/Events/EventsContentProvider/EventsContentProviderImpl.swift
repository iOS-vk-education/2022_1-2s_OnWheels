//
//  EventsContentProviderImpl.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

final class EventsContentProviderImpl: EventsContentProvider {
    private var eventsInfo: [RaceInfo] = []
    
    func getEvent(with index: Int) -> RaceInfo {
        return eventsInfo[index]
    }
    
    func insertEvents(with events: [RaceInfo]) {
        eventsInfo.insert(contentsOf: events, at: 0)
    }
}
