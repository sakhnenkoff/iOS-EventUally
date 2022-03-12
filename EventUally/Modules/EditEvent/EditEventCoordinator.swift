//
//  EditEventCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 08.03.2022.
//

import Foundation
import UIKit

final class EditEventCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let nav: UINavigationController
    
    var parentCoordinator: EventDetailCoordinator?
    
    private let event: Event
        
    init(with nav: UINavigationController, event: Event) {
        self.nav = nav
        self.event = event
    }
    
    func start() {
        let editEventVC: EditEventViewController = .instantiate(storyboard: .main)
        let viewModel = EditEventViewModel(cellBuilder: AddEventCellBuilder(), event: event)
        viewModel.coordinator = self
        editEventVC.viewModel = viewModel
        nav.pushViewController(editEventVC, animated: true)
    }
    
    func childDidFinish(child: Coordinator) {
        childCoordinators.removeAll() { $0 === child }
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        let imagePickerCoordinator = IamgePickerCoordinator(with: nav)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()

        imagePickerCoordinator.didFinishPicking = { image in
            completion(image)
        }
    }
    
    //MARK: - ViewModel Output
    
    func didFinish() {
        parentCoordinator?.childDidFinish(child: self)
    }
    
    func didFinishEditEvent() {
        parentCoordinator?.onUpdateEvent?()
        nav.popViewController(animated: true)
        parentCoordinator?.childDidFinish(child: self)
    }
    
}


