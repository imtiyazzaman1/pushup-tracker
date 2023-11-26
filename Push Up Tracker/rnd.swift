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
                if isTracking {
                    startTracking()
                } else {
                    stopTracking()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            ARFaceTrackingView(tracker: tracker, arView: arView)
                        .frame(width: 0, height: 0) // Invisible, as we only need the AR session
                
        }
    }

    private func startTracking() {
        let configuration = ARFaceTrackingConfiguration()
        // Add any additional configuration if needed

        // Assuming you have a reference to your ARSCNView
        arView.session.run(configuration)
    }

    private func stopTracking() {
        arView.session.pause()
    }
}

struct ARFaceTrackingView: UIViewRepresentable {
    @ObservedObject var tracker: StatefulTracker
    
    var arView: ARSCNView

    func makeUIView(context: Context) -> ARSCNView {
        arView.session.delegate = context.coordinator
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARFaceTrackingView

        init(_ parent: ARFaceTrackingView) {
            self.parent = parent
        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
            
            if (faceAnchor.isTracked) {
                parent.tracker.setPosition(PushUpPosition.up)
            } else {
                parent.tracker.setPosition(PushUpPosition.down)
            }
        }
    }
}



struct RnDView_Previews: PreviewProvider {
    static var previews: some View {
        RnDView()
    }
}
