//
//  AddEventCoreDataManager.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import CoreData

final class AddEventCoreDataManager: CoreDataBaseManager {
    func addNewEvent(_ eventInfo: AddEventInfoCDModel) {
        let newEvent = AddEventCDEntity(context: context)
        newEvent.nameText = eventInfo.name
        newEvent.dateFrom = eventInfo.dateFrom
        newEvent.dateTo = eventInfo.dateTo
        newEvent.location = eventInfo.loction
        newEvent.firstTag = eventInfo.firstTag
        newEvent.secondTag = eventInfo.secondTag
        newEvent.eventDescription = eventInfo.raceDescription
        newEvent.eventUId = eventInfo.uid
        
        saveContext()
        
    }
    
    func deleteEvent() {
        let fetchRequest = AddEventCDEntity.fetchRequest()
        guard let fetchedObjects = try? context.fetch(fetchRequest) else { return }
        
        fetchedObjects.forEach {
            context.delete($0)
        }
        saveContext()
    }
    
    func fetchEvents() -> [AddEventInfoCDModel] {
        let fetchRequest: NSFetchRequest<AddEventCDEntity> = AddEventCDEntity.fetchRequest()
        guard let objects = try? context.fetch(fetchRequest) else {
            return []
        }
        
        return objects.compactMap { AddEventInfoCDModel(from: $0) }
    }
}
