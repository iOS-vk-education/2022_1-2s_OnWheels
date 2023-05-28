//
//  AddEvent+CoreDataProperties.swift
//  OnWheels
//
//  Created by Veronika on 28.05.2023.
//
//

import Foundation
import CoreData


extension AddEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddEvent> {
        return NSFetchRequest<AddEvent>(entityName: "AddEvent")
    }

    @NSManaged public var dateFrom: String?
    @NSManaged public var dateTo: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventImage: Data?
    @NSManaged public var firstTag: String?
    @NSManaged public var location: String?
    @NSManaged public var nameText: String?
    @NSManaged public var secondTag: String?

}

extension AddEvent : Identifiable {

}
