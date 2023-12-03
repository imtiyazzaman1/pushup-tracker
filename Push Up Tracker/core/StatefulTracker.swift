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
    
    func setPosition(_ newPosition: PushUpPosition, _ acceleration: AccelerationData) -> Void {
        guard isDeviceLyingFlat(acceleration) else { return }
        
        let currentPosition = self.position
        if (currentPosition == PushUpPosition.down && newPosition == PushUpPosition.up) {
            count += 1
        }
        
        self.position = newPosition
    }
    
    private func isDeviceLyingFlat(_ acceleration: AccelerationData) -> Bool {
        let z = acceleration.z
        
        let isValidZ = z < -0.9 && z > -1.1
        
        return isValidZ
    }
}

enum PushUpPosition {
case up, down
}
