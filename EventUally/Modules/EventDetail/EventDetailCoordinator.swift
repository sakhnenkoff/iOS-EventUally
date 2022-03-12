//
//  EventDetailCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 06.03.2022.
//

import CoreData
import UIKit

final class EventDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: EventListCoordinator?
    
    var onUpdateEvent: (() -> Void)?
    
    let nav: UINavigationController
    let eventId: NSManagedObjectID
    
    init(with nav: UINavigationController, eventId: NSManagedObjectID) {
        self.nav = nav
        self.eventId = eventId
    }
    
    //MARK: - Configuration
    
    func start() {
        let viewModel = EventDetailViewModel(eventId: eventId, coordinator: self)
        let eventDetailVC: EventDetailViewController = .instantiate(storyboard: .main)
        eventDetailVC.viewModel = viewModel
        
        onUpdateEvent = {
            eventDetailVC.viewModel.reload()
            self.parentCoordinator?.onUpdateEvent?()
        }
        
        nav.pushViewController(eventDetailVC, animated: true)
    }
    
    func childDidFinish(child: Coordinator) {
        parentCoordinator?.childDidFinish(child: self)
    }
    
    //MARK: - ViewModel Output
    
    func onEditEvent(_ event: Event) {
        openEditEvent(event: event)
    }
    
    func onRemoveEvent() {
        parentCoordinator?.onUpdateEvent?()
        nav.popViewController(animated: true)
    }

    //MARK: - Navigation
    
    func openEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(with: nav, event: event)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
}
