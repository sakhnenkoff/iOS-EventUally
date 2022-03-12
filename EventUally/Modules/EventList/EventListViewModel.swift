//
//  EventListViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 17.02.2022.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?

    private let eventService: EventServiceProtocol
    
    var onDataUpdate: (() -> Void)?
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        reloadTable()
    }
    
    //MARK: - Actions
    
    func reloadTable() {
        EventCellViewModel.imageCache.removeAllObjects()
        let events = eventService.getEvents()
        cells = events?.map() {
            var eventCellViewModel = EventCellViewModel($0)
            eventCellViewModel.onSelect = { [weak self] id in
                self?.coordinator?.didSelectEvent(with: id)
            }
            return .event(eventCellViewModel)
        } ?? []
        
        onDataUpdate?()
    }
    
    func didSelectEvent(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let cellModel):
            cellModel.didSelect()
        }
    }
    
    func didRemoveEvent(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
            case .event(let eventModel):
            cells.remove(at: indexPath.row)
            eventService.perform(.remove(eventModel.event), input: nil)
        }
    }
    
    func didTapAddEvent() {
        coordinator?.openAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
}
