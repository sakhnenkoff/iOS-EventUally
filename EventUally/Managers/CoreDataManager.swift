//
//  CoreDataManager.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 17.02.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventUally")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription)
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    //MARK: - Actions
    
    func save() {
        try? moc.save()
    }
    
    func fetchData<T: NSManagedObject>() -> [T]? {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            let data = try moc.fetch(fetchRequest)
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            let object = try moc.existingObject(with: id) as? T
            return object
        } catch {
            print(error)
            return nil
        }
        return nil
    }
    
    func removeObject(_ object: NSManagedObject) {
        moc.delete(object)
    }
}

//MARK: - Extensions

extension Event {
    enum EventKeys: String {
        case name
        case image 
        case date
    }
    
    func setValue(_ value: Any?, definedKey: EventKeys) {
        setValue(value, forKey: definedKey.rawValue)
    }
}
