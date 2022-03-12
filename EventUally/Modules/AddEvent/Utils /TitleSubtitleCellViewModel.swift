//
//  TitleSubtitleCellViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 20.02.2022.
//

import Foundation
import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    var onUpdateCell: (() -> Void)?
    
    let title: String
    var subtitle: String
    let placeholder: String?
    
    var image: UIImage?
    
    let type: CellType
    
    init(title: String, subtitle: String, placeholder: String?, type: CellType, onUpdateCell: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onUpdateCell = onUpdateCell
    }
    
    //MARK: - Updates
    
    public func updateSubtitle(_ subtitle: String) {
        self.subtitle = subtitle
        onUpdateCell?()
    }
    
    public func updateImage(_ image: UIImage) {
        self.image = image
        onUpdateCell?()
    }
}
