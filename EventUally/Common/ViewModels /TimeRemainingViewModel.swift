//
//  TimeRemainingViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 06.03.2022.
//

import UIKit

final class TimeRemainingViewModel {
    
    enum Mode {
        case cell
        case detail
    }
    
    let timeRemainingParts: [String]
    private let mode: Mode
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:
            return 25
        case .detail:
            return 44
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }

    init(timeRemainingParts: [String], mode: Mode) {
        self.timeRemainingParts = timeRemainingParts
        self.mode = mode
    }
    
}
