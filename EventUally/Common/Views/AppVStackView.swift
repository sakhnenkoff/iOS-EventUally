//
//  AppVStackView.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 03.03.2022.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    
    private var timeRemainingLabels = [UILabel(),UILabel(),UILabel()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configure() {
        timeRemainingLabels.forEach { addArrangedSubview($0) }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    //MARK: - Public
    
    func configure(with viewModel: TimeRemainingViewModel) {
        timeRemainingLabels.forEach() {
            $0.text = nil
            $0.font = .systemFont(ofSize: viewModel.fontSize)
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        alignment = viewModel.alignment
        
        viewModel.timeRemainingParts.enumerated().forEach() {
            timeRemainingLabels[$0.offset].text = $0.element
        }
    }
}
