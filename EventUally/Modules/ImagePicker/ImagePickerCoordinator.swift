//
//  ImagePickerCoordinator.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 27.02.2022.
//

import Foundation
import UIKit

final class IamgePickerCoordinator: NSObject, Coordinator {
    
    private(set)var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    public var didFinishPicking: ((UIImage) -> Void)?
    
    private let nav: UINavigationController
    
    init(with nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
        nav.present(imagePicker, animated: true)
    }
    
    func childDidFinish(child: Coordinator) {
        parentCoordinator?.childDidFinish(child: self)
    }
    
}

extension IamgePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let picture = info[.originalImage] as? UIImage {
            didFinishPicking?(picture)
        }
        
        picker.dismiss(animated: true)
    }
}
