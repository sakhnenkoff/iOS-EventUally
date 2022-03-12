//
//  EventCellViewModel.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 02.03.2022.
//

import Foundation
import UIKit
import CoreData

struct EventCellViewModel {
    
    let event: Event
    
    let date = Date()
    
    static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    var onSelect: ((NSManagedObjectID) -> Void)?
    
    var onRemove: ((Event) -> Void)?
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        // 1 year, 2 months
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        return DateFormatter.dateStringForCell(eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event.date else { return nil }
        guard let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
        
    init(_ event: Event) {
        self.event = event
    }
    
    //MARK: - Configuration
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = event.image, let image = UIImage(data: imageData) else { completion(nil); return }
                Self.imageCache.setObject(image, forKey: cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    //MARK: - Actions
    
    func didSelect() {
        onSelect?(event.objectID)
    }
    
}
