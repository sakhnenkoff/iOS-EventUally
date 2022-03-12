//
//  EventListCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 15.02.2022.
//

import CoreData
import UIKit

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    var onUpdateEvent: (() -> Void)?
    
    private let nav: UINavigationController
    
    init(nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        let eventListVC: EventListViewController = .instantiate(storyboard: .main)
        eventListVC.viewModel = EventListViewModel()        
        eventListVC.viewModel.coordinator = self
        
        onUpdateEvent = {
            eventListVC.viewModel.reloadTable()
        }
        
        nav.setViewControllers([eventListVC], animated: false)
    }
    
    func childDidFinish(child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
    
    //MARK: - ViewModel Output
    
    func didSelectEvent(with id: NSManagedObjectID) {
        openEventDetail(with: id)
    }
    
    //MARK: - Navigation 
    
    func openAddEvent() {
        let addEventCoordinator = AddEventCoordinator(with: nav)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func openEventDetail(with id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(with: nav, eventId: id)
        eventDetailCoordinator.parentCoordinator = self 
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
    
}
