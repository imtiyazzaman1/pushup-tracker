//
//  StatefulTrackerTests.swift
//  Push Up TrackerTests
//
//  Created by Imtiyaz Zaman on 26/11/2023.
//

import XCTest
@testable import Push_Up_Tracker

final class StatefulTrackerTests: XCTestCase {
    let acceleration = AccelerationData(x: -0.003, y: -0.03, z: -0.998)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountIncreases() -> Void {
        let tracker = StatefulTracker()
        
        tracker.setPosition(PushUpPosition.up, acceleration)
        tracker.setPosition(PushUpPosition.down, acceleration)
        tracker.setPosition(PushUpPosition.up, acceleration)
        
        XCTAssertEqual(tracker.count, 1)
    }
    
    func testTrackerReset() -> Void {
        let tracker = StatefulTracker()
        
        tracker.setPosition(PushUpPosition.up, acceleration)
        tracker.setPosition(PushUpPosition.down, acceleration)
        tracker.setPosition(PushUpPosition.up, acceleration)
        tracker.setPosition(PushUpPosition.down, acceleration)
        
        XCTAssertEqual(tracker.count, 1)
        
        tracker.reset()
        
        XCTAssertEqual(tracker.count, 0)
    }
}
