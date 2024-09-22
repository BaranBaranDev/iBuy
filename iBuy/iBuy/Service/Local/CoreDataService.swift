//
//  CoreDataService.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import Foundation
import CoreData

// MARK: - CoreDataServiceProtocol
protocol CoreDataServiceProtocol {
    func saveObject<T: NSManagedObject>(_ object: T)
    func fetchObjects<T: NSManagedObject>(_ objectType: T.Type) -> [T]
    func deleteObject<T: NSManagedObject>(_ object: T)
}

// MARK: - CoreDataService Class
final class CoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iBuyDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - CoreDataServiceProtocol Implement
extension CoreDataService: CoreDataServiceProtocol {
    
    func saveObject<T: NSManagedObject>(_ object: T) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchObjects<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects
        } catch {
            let nserror = error as NSError
            fatalError("Error: \(nserror), \(nserror.userInfo)")
        }
    }
    

    func deleteObject<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        saveContext()
    }
}
