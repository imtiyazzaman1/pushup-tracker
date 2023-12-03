//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \PushUpSet.timestamp, order: .reverse)
    private var sets: [PushUpSet]
    
    @StateObject private var tracker: StatefulTracker = StatefulTracker()
    
    @State private var isTracking = false
    @State private var total: Int = 0
    
    private let dateFormatter = DateFormatter()
   
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    var body: some View {
        VStack {
            Text("Push-Up Counter")
                .font(.largeTitle)

            Text("\(tracker.count)")
                .font(.system(size: 100))
                .fontWeight(.bold)
            
            Text("\(total)")

            Button(isTracking ? "Stop" : "Start") {
                isTracking.toggle()
                if (isTracking) {
                    start()
                } else {
                    stop()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            ARFaceTrackingView(tracker: tracker, isTracking: $isTracking)
                        .frame(width: 0, height: 0)
            
            List{
                ForEach(sets) { pushUpSet in
                    Text("\(dateFormatter.string(from: pushUpSet.timestamp)) - \(pushUpSet.reps)")
                }
            }

        }
        .onAppear {
            calculateTotal()
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
    ContentView()
        .modelContainer(for: PushUpSet.self, inMemory: true)
}
