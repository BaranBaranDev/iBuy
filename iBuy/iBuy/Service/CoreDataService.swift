//
//  CoreDataService.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import Foundation
import CoreData

// MARK: - CoreDataServiceProtocol
// Bu protokol, NSManagedObject türündeki nesneleri kaydetmek ve getirmek için iki genel fonksiyon tanımlar.
// Core Data mantığını soyutlar ve diğer sınıfların Core Data ile nasıl çalıştığını bilmeden etkileşime
// geçmesini sağlar.
protocol CoreDataServiceProtocol {
    func saveObject<T: NSManagedObject>(_ object: T)       // İsimlendirmenin daha anlamlı olması için save -> saveObject
    func fetchObjects<T: NSManagedObject>(_ objectType: T.Type) -> [T]   // fetch -> fetchObjects
}

// MARK: - CoreDataService Class
// Bu sınıf CoreDataServiceProtocol'u uygular ve Core Data işlemlerini yönetir.
// Singleton bir yapıdadır ve Core Data işlemlerini yönetmek için temel fonksiyonlar sağlar.
final class CoreDataService {
  
    // Core Data konteyneri, veritabanını ve persistent store'ları yönetir.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iBuyDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Çözülemeyen hata: \(error), \(error.userInfo)") // Hata durumunda uygulama çöker.
            }
        })
        return container
    }()
    
    // Konteyner'den alınan ana yönetimsel bağlam (context), Core Data ile işlemleri yönetir.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Değişiklikler varsa context'i kaydeder.
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Çözülemeyen hata: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - CoreDataServiceProtocol Implement
// Protokol'deki metotlar burada uygulanır.
extension CoreDataService: CoreDataServiceProtocol {
    
    // Genel nesne kaydetme fonksiyonu
    func saveObject<T: NSManagedObject>(_ object: T) {
        do {
            try context.save()   // Kaydetme işlemi yapılır.
        } catch {
            let nserror = error as NSError
            fatalError("Çözülemeyen hata: \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Genel nesne getirme fonksiyonu
    func fetchObjects<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)   // Nesne türünden varlık adını alır.
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)   // İlgili varlık için bir fetchRequest oluşturur.
        do {
            let fetchedObjects = try context.fetch(fetchRequest)  // Nesneleri getirir.
            return fetchedObjects
        } catch {
            let nserror = error as NSError
            fatalError("Çözülemeyen hata: \(nserror), \(nserror.userInfo)")
        }
    }
}
