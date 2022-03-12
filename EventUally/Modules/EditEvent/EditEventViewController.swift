//
//  EditEventViewController.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 08.03.2022.
//

import UIKit

final class EditEventViewController: UIViewController {
    
    var viewModel: EditEventViewModel!
    
    lazy var dateFormatter = DateFormatter.appDateFormatter
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: String(describing: TitleSubtitleCell.self))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        viewModel.viewDidDisappear()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.createCells()
        
        viewModel.onUpdateCell = { [weak self] in
            self?.tableView.reloadData()
        }
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // forcing large title on modal vc
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        
        let titleView = UIView()
        
        let navigationPillImageView = UIImageView()
        navigationPillImageView.image = UIImage(named: "img-sheet-bar")
        
        navigationItem.titleView = titleView
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    }
    
    //MARK: - Actions
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
        viewModel.didTapDoneButton()
    }
}

//MARK: - Extensions

extension EditEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.cells[indexPath.row]
        switch cellViewModel {
        case .titleSubtitle(let cellModel):
            if cellModel.type == .image {
                viewModel.coordinator?.showImagePicker() { image in
                    cellModel.updateImage(image)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cells[indexPath.row]
        
        switch cellViewModel {
            case .titleSubtitle(let titleCellModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleSubtitleCell.self), for: indexPath) as! TitleSubtitleCell
            
            cell.configureCell(with: titleCellModel)
            cell.subtitleTextField.delegate = self
                        
            cell.didUpdateDate = { [weak self] date in
                if let dateString = self?.dateFormatter.string(from: date) {
                    self?.viewModel.updateDateCell(date: dateString)
                    cell.subtitleTextField.text = dateString
                }
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    
    }
}

extension EditEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        viewModel.updateNameCell(text: text)
        
        return true
    }
}
