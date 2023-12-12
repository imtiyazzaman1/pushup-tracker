//
//  TrackingView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData

struct TrackingView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \PushUpSet.timestamp, order: .reverse)
    private var sets: [PushUpSet]
    
    @StateObject private var tracker: StatefulTracker = StatefulTracker()
    
    @State private var isTracking = false
    @State private var total: Int = 0
    
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            Text("\(tracker.count)")
                .font(.system(size: 100))
                .fontWeight(.bold)
            
            Button(isTracking ? "Stop" : "Start") {
                isTracking.toggle()
                if (isTracking) {
                    start()
                } else {
                    stop()
                }
            }
            .padding()
            .background(isTracking ? Color.red : Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            ARFaceTrackingView(tracker: tracker, isTracking: $isTracking)
                        .frame(width: 0, height: 0)
        }
    }
    
    func start() {
        isTracking = true
    }
    
    func stop() {
        isTracking = false
        save()
        tracker.reset()
    }
    
    private func save() {
        let p = PushUpSet(tracker.count)
        modelContext.insert(p)
    }
    
    private func calculateTotal() {
        self.total = sets.reduce(0, { (res: Int, pushUpSet: PushUpSet) -> Int in
            return res + pushUpSet.reps
        })
    }
}

#Preview {
    TrackingView()
}
