//
//  AppButtonView.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 03.03.2022.
//

import UIKit

final class AppButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(bgColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
    }
    
    //MARK: - Configuration
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
