//
//  EventCellBuilder.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 01.03.2022.
//

import Foundation

struct AddEventCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(title: "Name", subtitle: "", placeholder: "Add a name", type: .text, onUpdateCell: onCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel(title: "Date", subtitle: "", placeholder: "Select a date", type: .date, onUpdateCell: onCellUpdate)
        case .image:
            return TitleSubtitleCellViewModel(title: "Image", subtitle: "", placeholder: nil, type: .image, onUpdateCell: onCellUpdate)
        }
    }
}
