//
//  PreviewDataController.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/12/2023.
//

import Foundation
import SwiftData

@MainActor
class PreviewDataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: PushUpSet.self, configurations: config)
            
            let calendar = Calendar.current
            
            for i in 1..<6 {
                let reps = Int.random(in: 1...50)
                
                let set = PushUpSet(reps, Date())
                container.mainContext.insert(set)
            }
            
            for i in 1..<20 {
                let reps = Int.random(in: 1...50)
                let today = calendar.startOfDay(for: Date())
                let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
                
                let timestamp = calendar.date(byAdding: .day, value: Int.random(in: -5..<0), to: yesterday)!
                
                let set = PushUpSet(reps, timestamp)
                container.mainContext.insert(set)
            }
            
            return container
        } catch {
           fatalError("Failed to create model container for previewing: \(error)")
        }
    }()
    
    static func generateRandomDate(startDate: Date, endDate: Date) -> Date {
        /**
         This function generates a random date within the given boundaries.
         
         - Parameters:
            - startDate: The start date boundary
            - endDate: The end date boundary
         
         - Returns: A random date between the start and end dates
         */
        
        // Calculate the time interval between the start and end dates
        let timeInterval = endDate.timeIntervalSince(startDate)
        
        // Generate a random number within the time interval
        let randomTimeInterval = TimeInterval(arc4random_uniform(UInt32(timeInterval)))
        
        // Calculate the random date
        let randomDate = startDate.addingTimeInterval(randomTimeInterval)
        
        return randomDate
    }
}
