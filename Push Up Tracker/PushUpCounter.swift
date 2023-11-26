//
//  PushUpCounter.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 26/11/2023.
//

import Foundation

class PushUpCounter {
    var count: Int
    var state: PushUpState
    
    init() {
        self.count = 0
        self.state = PushUpState.up
    }
    
    func setState(_ state: PushUpState) -> Void {
        let currentState = self.state
        
        self.state = state
    }
}

enum PushUpState{
    case up, down
}
