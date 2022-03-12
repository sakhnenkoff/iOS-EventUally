//
//  UIDateFormatter + Extensions.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 22.02.2022.
//

import Foundation

extension DateFormatter {
    static let appDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let cellDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = .current
        return formatter
    }()
    
    static func dateStringForCell(_ date: Date) -> String {
        cellDateFormatter.string(from: date)
    }
}
