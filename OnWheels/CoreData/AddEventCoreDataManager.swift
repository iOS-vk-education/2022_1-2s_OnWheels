//
//  AddEventCoreDataManager.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import CoreData

final class FavouritesCoreDataManager: CoreDataBaseManager {
    func addNewEvent(_ eventInfo: AddEventInfoCDModel) {
        let newEvent = AddEventCDEntity(context: context)
        newEvent.nameText = eventInfo.name
        newEvent.dateFrom = eventInfo.dateFrom
        newEvent.dateTo = eventInfo.dateTo
        newEvent.location = eventInfo.loction
        newEvent.firstTag = eventInfo.firstTag
        newEvent.secondTag = eventInfo.secondTag
        newEvent.eventDescription = eventInfo.raceDescription
        newEvent.eventImage = eventInfo.imageData
        
        saveContext()
        
    }
    
    func deleteEvent() {
        let fetchRequest = AddEventCDEntity.fetchRequest()
        guard let fetchedObjects = try? context.fetch(fetchRequest) else { return }
        
        fetchedObjects.forEach {
            backgroundContext.delete($0)
        }
    }
    
    func fetchEvents() -> [AddEventInfoCDModel] {
        let fetchRequest: NSFetchRequest<AddEventCDEntity> = AddEventCDEntity.fetchRequest()
        let objects = try? context.fetch(fetchRequest)
        
        return objects?.compactMap { AddEventInfoCDModel(from: $0) } ?? []
    }
}
