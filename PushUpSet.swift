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
    var timestamp: Date = Date()
    var reps: Int

    public init(_ reps: Int) { 
        self.reps = reps
    }
    
}
