//
//  CoreDataBaseManager.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import CoreData

class CoreDataBaseManager {
    enum ModelName: String {
        case eventDataModel = "Events"
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("[DEBUG]: - Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private(set) lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    private let modelName: ModelName
    
    init(modelName: ModelName) {
        self.modelName = modelName
    }
}

extension CoreDataBaseManager {
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                debugPrint("[DEBUG]: - Context has not been saved")
            }
        }
    }
}
