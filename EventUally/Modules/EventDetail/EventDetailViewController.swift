//
//  EventDetailViewController.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 06.03.2022.
//

import UIKit
import SnapKit

final class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private let timeRemainingStackView = TimeRemainingStackView()
    
    var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.viewDidDisappear()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        viewModel.onUpdate = { [weak self] in
            self?.backgroundImageView.image = self?.viewModel.image
            self?.configureStackView()
        }
        
        let _ = ImageOverlayView(for: backgroundImageView)
    }
    
    private func configureStackView() {
        guard let stackModel = viewModel.timeRemainingViewModel else { return }
        
        view.addSubview(timeRemainingStackView)
        
        timeRemainingStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(34)
            make.right.equalToSuperview().offset(-34)
            make.centerY.equalToSuperview()
        }
        
        timeRemainingStackView.configure(with: stackModel)
    }
    
    private func configureNavigation() {
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        let removeItem = UIBarButtonItem(image: .remove, landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapRemoveButton))
        navigationItem.rightBarButtonItems = [removeItem,editItem]
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func didTapEditButton() {
        viewModel.didTapEditButton()
    }
        
    @objc private func didTapRemoveButton() {
        viewModel.didTapRemoveButton()
    }
}
