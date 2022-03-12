//
//  EventService.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 09.03.2022.
//

import UIKit
import CoreData

protocol EventServiceProtocol {
    func perform(_ action: EventService.EventAction, input: EventService.EventInputData?)
    
    func getEvent(_ id: NSManagedObjectID) -> Event
    func getEvents() -> [Event]?
}

final class EventService: EventServiceProtocol {
    
    struct EventInputData {
        let name: String
        let date: Date
        let image: UIImage
    }
    
    enum EventAction {
        case add
        case update(Event)
        case remove(Event)
    }
    
    private let coreDataManager: CoreDataManager
    
    init(coredataManager: CoreDataManager = .shared) {
        self.coreDataManager = coredataManager
    }
    
    func perform(_ action: EventAction, input: EventInputData?) {
        var event: Event
        
        switch action {
        case .add:
            guard let input = input else { return }
            event = Event(context: coreDataManager.moc)
            
            let resized = input.image.sameAspectRatio(newHeight: 250)
            let imageData = resized.jpegData(compressionQuality: 0.6)
            
            event.setValue(input.name, definedKey: .name)
            event.setValue(imageData, definedKey: .image)
            event.setValue(input.date, definedKey: .date)
            
            try? coreDataManager.save()
            
        case .update(let eventToUpdate):
            guard let input = input else { return }
            event = eventToUpdate
            
            let resized = input.image.sameAspectRatio(newHeight: 250)
            let imageData = resized.jpegData(compressionQuality: 0.6)

            event.setValue(input.name, definedKey: .name)
            event.setValue(imageData, definedKey: .image)
            event.setValue(input.date, definedKey: .date)
            
            try? coreDataManager.save()
            
            case .remove(let eventToDelete):
                event = eventToDelete
            coreDataManager.removeObject(eventToDelete)
            
            try? coreDataManager.save()
        }
        
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event {
        return coreDataManager.get(id) as! Event
    }

    func getEvents() -> [Event]? {
        return coreDataManager.fetchData()
    }
}
