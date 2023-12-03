//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import CoreData
import CoreMotion

struct RnDView: View {
    @StateObject private var tracker: StatefulTracker = StatefulTracker()
    
    @State private var isTracking = false
    
    var body: some View {
        VStack {
            Text("Push-Up Counter")
                .font(.largeTitle)

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
            .background(Color.blue)
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
    }
}


struct RnDView_Previews: PreviewProvider {
    static var previews: some View {
        RnDView()
    }
}
