//
//  Date+Extensions.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 03.03.2022.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        
        print( dateComponentsFormatter.string(from: self, to: endDate))
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
    
}
