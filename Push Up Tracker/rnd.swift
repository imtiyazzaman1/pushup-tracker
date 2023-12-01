//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import CoreData
import ARKit

struct RnDView: View {
    private var arView: ARSCNView = ARSCNView()
    
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
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            ARFaceTrackingView(tracker: tracker, isTracking: $isTracking)
                        .frame(width: 0, height: 0)
        }
    }
}


struct RnDView_Previews: PreviewProvider {
    static var previews: some View {
        RnDView()
    }
}
