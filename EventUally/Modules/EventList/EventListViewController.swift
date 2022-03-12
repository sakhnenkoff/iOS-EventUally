//
//  EventListViewController.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 15.02.2022.
//

import UIKit
import SnapKit
import SwipeCellKit

final class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EventCell.self, forCellReuseIdentifier: String.init(describing: EventCell.self))
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        configureNavigationBar()
        
        viewModel.onDataUpdate = {
            self.tableView.reloadData()
        }
    }
        
    private func configureNavigationBar() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        barButton.tintColor = UIColor.ApplicationPalette.primary
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Actions
    
    @objc private func didTapAddButton() {
        viewModel.didTapAddEvent()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
}

//MARK: - Extensions

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRows())
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as! EventCell
            cell.configure(with: eventCellViewModel)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectEvent(at: indexPath)
    }

}

extension EventListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            print("Did swipe cell for \(indexPath)")
            
            self?.viewModel.didRemoveEvent(at: indexPath)
            
            action.fulfill(with: .delete)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
    
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructiveAfterFill
        options.transitionStyle = .drag
        return options
    }
}

