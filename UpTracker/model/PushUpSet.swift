//
//  PushUpSet.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//
//

import Foundation
import SwiftData


@Model public class PushUpSet {
    var reps: Int
    var timestamp: Date
    var day: Date

    convenience public init(_ reps: Int) {
        self.init(reps, Date())
    }
    
    init(_ reps: Int, _ date: Date) {
        self.reps = reps
        self.timestamp = date
        self.day = Calendar.current.startOfDay(for: date)
    }
    
    static func todayPredicate() -> Predicate<PushUpSet> {
        let today = Calendar.current.startOfDay(for: Date())
        
        return #Predicate<PushUpSet> { set in
            set.timestamp >= today
        }
    }
}
