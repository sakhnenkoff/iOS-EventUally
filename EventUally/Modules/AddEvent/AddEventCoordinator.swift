//
//  AddEventCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 17.02.2022.
//

import Foundation
import UIKit

final class AddEventCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let nav: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    
    var modelNav: UINavigationController?
    
    init(with nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        let modalNavigationController = UINavigationController()
        self.modelNav = modalNavigationController
        let addEventVC: AddEventViewController = .instantiate(storyboard: .main)
        modelNav?.setViewControllers([addEventVC], animated: false)
        let viewModel = AddEventViewModel(cellBuilder: AddEventCellBuilder())
        viewModel.coordinator = self
        addEventVC.viewModel = viewModel
        nav.present(modelNav!, animated: true)
    }
    
    func childDidFinish(child: Coordinator) {
        childCoordinators.removeAll() { $0 === child }
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        guard let modelNav = modelNav else { return }
        let imagePickerCoordinator = IamgePickerCoordinator(with: modelNav)
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
    
    func didFinishSaveEvent() {
        parentCoordinator?.onUpdateEvent?()
        nav.dismiss(animated: true, completion: nil)
    }
    
}
