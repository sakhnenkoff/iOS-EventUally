//
//  EditEventViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 08.03.2022.
//

import Foundation
import UIKit
import SnapKit

final class EditEventViewModel {
    
    weak var coordinator: EditEventCoordinator?
    
    private let cellBuilder: AddEventCellBuilder
    private let eventService: EventServiceProtocol
    
    private let event: Event
    
    let title = "Edit"
    
    var onUpdateCell: (() -> Void)?
    
    var currentText: String?

    var currentImage: UIImage?
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var imageCellViewModel: TitleSubtitleCellViewModel? {
        didSet {}
    }
    
    lazy var dateFormatter = DateFormatter.appDateFormatter
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    //MARK: - View Lifecycle
    
    func viewDidLoad() {
    }
        
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    init(cellBuilder: AddEventCellBuilder, eventService: EventServiceProtocol = EventService(), event: Event) {
        self.cellBuilder = cellBuilder
        self.eventService = eventService
        self.event = event
    }
    
    
    //MARK: - TableView
    
    func createCells() {
        
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text) { [weak self] in
            self?.onUpdateCell?()
        }
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdateCell?()
        }
        imageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdateCell?()
        }
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let imageCellViewModel = imageCellViewModel else { return }

        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(imageCellViewModel),
        ]
        
        guard let name = event.name, let date = event.date, let imageData = event.image, let image = UIImage(data: imageData) else { return }
        
        imageCellViewModel.image = image
        
        updateNameCell(text: name)
        updateDateCell(date: DateFormatter.appDateFormatter.string(from: date))
        
        onUpdateCell?()
    }
    
    func getNumberOfRows() -> Int {
        return cells.count
    }
    
    func updateNameCell(text: String) {
        nameCellViewModel?.subtitle = text
    }
    
    func updateDateCell(date: String) {
        dateCellViewModel?.subtitle = date
    }
    
    //MARK: - View Output
    
    func didTapDoneButton() {
        guard let name = nameCellViewModel?.subtitle, let date = dateCellViewModel?.subtitle, let image = imageCellViewModel?.image, let rawDate = dateFormatter.date(from: date) else { return }
        
        eventService.perform(.update(event), input: .init(name: name, date: rawDate, image: image))
        coordinator?.didFinishEditEvent()
    }
    
}

