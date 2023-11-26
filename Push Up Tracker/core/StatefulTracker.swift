//
//  StatefulTracker.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 26/11/2023.
//

import Foundation

class StatefulTracker: ObservableObject {
    @Published var count: Int = 0
    
    private var position: PushUpPosition = PushUpPosition.up
    
    func reset() -> Void {
        self.count = 0
        self.position = PushUpPosition.up
    }
    
    func setPosition(_ newPosition: PushUpPosition) -> Void {
        let currentPosition = self.position
        
        if (currentPosition == PushUpPosition.down && newPosition == PushUpPosition.up) {
            count += 1
        }
        
        self.position = newPosition
    }
}

enum PushUpPosition {
case up, down
}
