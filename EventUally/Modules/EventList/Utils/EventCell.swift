//
//  EventCell.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 02.03.2022.
//

import UIKit
import SnapKit
import SwipeCellKit

final class EventCell: SwipeTableViewCell {
    
    private let timeRemainingStack = TimeRemainingStackView()
    
    private let containerView = UIView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        return stack
    }()

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        configureHierarchy()
        configureLayout()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configureViews() {
        let _ = ImageOverlayView(for: backgroundImageView)
    }
    
    private func configureHierarchy() {
        contentView.addSubview(containerView)
        containerView.addMoreSubviews(backgroundImageView, vStackView, eventNameLabel)
        
        vStackView.addArrangedSubview(timeRemainingStack)
        vStackView.addArrangedSubview(UIView())
        vStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureLayout() {
        
        containerView.snp.makeConstraints() { make in
            make.left.top.equalToSuperview().offset(14)
            make.right.bottom.equalToSuperview().offset(-14)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(250)
        }
    
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalTo(vStackView.snp.right)
            make.width.greaterThanOrEqualTo(120)
        }
    
        eventNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(140)
        }
        
    }
    
    //MARK: - Public
    
    func configure(with viewModel: EventCellViewModel) {
        guard let stackModel = viewModel.timeRemainingViewModel else { return }
        timeRemainingStack.configure(with: stackModel)
        self.dateLabel.text = viewModel.dateText
        self.eventNameLabel.text = viewModel.eventName
        viewModel.loadImage() { self.backgroundImageView.image = $0 }
    }
    
}
    

