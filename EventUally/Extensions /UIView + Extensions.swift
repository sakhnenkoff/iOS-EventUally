//
//  UIView + Extensions.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 20.02.2022.
//

import Foundation
import UIKit

extension UIView {
    func addMoreSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    var width: CGFloat { self.frame.size.width }
    var height: CGFloat { self.frame.size.height }
}
