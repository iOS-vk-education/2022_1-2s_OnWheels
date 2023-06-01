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
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Events")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
     
    
    private(set) lazy var context: NSManagedObjectContext = {
        return CoreDataBaseManager.persistentContainer.viewContext
    }()
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        return CoreDataBaseManager.persistentContainer.newBackgroundContext()
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
