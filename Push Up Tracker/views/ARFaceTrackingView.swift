//
//  ARFaceTrackingView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 01/12/2023.
//

import SwiftUI
import ARKit

struct ARFaceTrackingView: UIViewRepresentable {
    @ObservedObject var tracker: StatefulTracker
    @Binding var isTracking: Bool
    
    static var arView: ARSCNView = ARSCNView()
    static var configuration = ARFaceTrackingConfiguration()
    
    func makeUIView(context: Context) -> ARSCNView {
        ARFaceTrackingView.arView.session.delegate = context.coordinator
        
        return ARFaceTrackingView.arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        if (isTracking) {
            ARFaceTrackingView.arView.session.run(ARFaceTrackingView.configuration)
        } else {
            ARFaceTrackingView.arView.session.pause()
        }
    }
    
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
