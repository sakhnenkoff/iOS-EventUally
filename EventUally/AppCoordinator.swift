//
//  AppCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 15.02.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    
    func start()
    
    func childDidFinish(child: Coordinator)
}

final class AppCoordinator: Coordinator {
      
    private(set) var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator? // 
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(nav: navigationController)
        childCoordinators.append(eventListCoordinator)
        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func childDidFinish(child: Coordinator) {
        
    }
    
}
