//
//  EventDetailViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 06.03.2022.
//

import Foundation
import CoreData
import UIKit

final class EventDetailViewModel {
    
    var onUpdate: (() -> Void)?
    
    private let date = Date()
    private let eventId: NSManagedObjectID
    private let eventService: EventServiceProtocol
    private var event: Event?
    
    private let coordinator: EventDetailCoordinator
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let event = event, let eventDate = event.date else { return nil }
        guard let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventId: NSManagedObjectID, eventService: EventServiceProtocol = EventService(), coordinator: EventDetailCoordinator) {
        self.eventId = eventId
        self.eventService = eventService
        self.coordinator = coordinator
    }
    
    //MARK: - View Lifecylce
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator.childDidFinish(child: coordinator)
    }
    
    //MARK: - View Output
    
    func didTapEditButton() {
        guard let event = event else { return }
        coordinator.onEditEvent(event)
    }
    
    func didTapRemoveButton() {
        guard let event = event else { return }
        eventService.perform(.remove(event), input: nil)
        coordinator.onRemoveEvent()
    }
    
    //MARK: - Coordinator Input
    
    func reload() {
        event = eventService.getEvent(eventId)
        onUpdate?()
    }
    
}
