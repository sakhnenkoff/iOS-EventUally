//
//  ImageOverlayView.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 10.03.2022.
//

import UIKit
import SnapKit

final class ImageOverlayView: UIView {
    
    private var imageView: UIImageView
    
    init(for imageView: UIImageView) {
        self.imageView = imageView
        super.init(frame: .zero)
        
        configure()
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        imageView.addSubview(self)
        self.backgroundColor = .black
        self.alpha = 0.2
            
        self.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(imageView)
        }
    }
    
}
