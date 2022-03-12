//
//  UIViewController + Extensions.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 15.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum Storyboards: String {
        case main = "Main"
    }
    
    static func instantiate<T: UIViewController>(storyboard: Storyboards) -> T {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        let controller = sb.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return controller
    }
}
