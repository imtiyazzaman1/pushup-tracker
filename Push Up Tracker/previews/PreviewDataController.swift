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
            
            for i in 1..<10 {
                let set = PushUpSet(i)
                container.mainContext.insert(set)
            }
            
            return container
        } catch {
           fatalError("Failed to create model container for previewing: \(error)")
        }
    }()
}
