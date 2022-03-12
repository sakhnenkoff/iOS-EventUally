//
//  TitleSubtitleCell.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 20.02.2022.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    
    var didUpdateDate: ((Date) -> Void)?
    
    public var viewModel: TitleSubtitleCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
  
    public let subtitleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        return textField
    }()
    
    private var cellImgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.4)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()
    
    lazy private var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: (datePickerView.height / 100) * 25))
        return toolbar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureToolbar()
        
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        cellImgeView.addGestureRecognizer(tap)
    }
    
    private func configureHierarchy() {
        contentView.addMoreSubviews(verticalStack)
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(subtitleTextField)
        verticalStack.addArrangedSubview(cellImgeView)
    }
    
    private func configureLayout() {
        verticalStack.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(12)
            make.right.bottom.equalToSuperview().offset(-12)
        }
        
        cellImgeView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        toolbar.setItems([doneButton], animated: false)
    }
    
    //MARK: - Actions
    
    @objc private func didTapDoneButton() {
        subtitleTextField.resignFirstResponder()
    
        didUpdateDate?(datePickerView.date)
        print(#function)
    }

    @objc private func didTapImageView() {
        print(#function)
    }
    
    //MARK: - Public
    
    func configureCell(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.subtitleTextField.text = viewModel.subtitle
        self.subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        viewModel.onUpdateCell = { [weak self] in
            self?.cellImgeView.image = viewModel.image
        }
        
        cellImgeView.image = viewModel.image
        
        cellImgeView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image 
    }
    
}




