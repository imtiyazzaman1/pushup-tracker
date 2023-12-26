//
//  ARFaceTrackingView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 01/12/2023.
//

import SwiftUI
import ARKit
import CoreMotion

struct ARFaceTrackingView: UIViewRepresentable {
    @ObservedObject var tracker: StatefulTracker
    @Binding var isTracking: Bool
    
    static var arView: ARSCNView = ARSCNView()
    static var configuration = ARFaceTrackingConfiguration()
    
    var motionManager: CMMotionManager = CMMotionManager()
    
    func makeUIView(context: Context) -> ARSCNView {
        motionManager.accelerometerUpdateInterval = 0.5
        ARFaceTrackingView.arView.session.delegate = context.coordinator
        
        return ARFaceTrackingView.arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        if (isTracking) {
            let configuration = ARFaceTrackingView.configuration
            
            configuration.isLightEstimationEnabled = false
            configuration.worldAlignment = .gravity
            configuration.maximumNumberOfTrackedFaces = 1
            
            ARFaceTrackingView.arView.session.run(ARFaceTrackingView.configuration)
        } else {
            ARFaceTrackingView.arView.session.pause()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        let threshold: Float = 0.1
        var parent: ARFaceTrackingView

        init(_ parent: ARFaceTrackingView) {
            self.parent = parent
        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            parent.motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [self] (accelData, error) in
                guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
                guard let acceleration = accelData?.acceleration else { return }
                guard isDeviceLyingFlat(acceleration) else { return  }
                
                let z = roundTo1Dp(faceAnchor.transform.columns.2.z)
                
                guard z >= 0 else { return }
                
                if (!faceAnchor.isTracked && z <= threshold) {
                    parent.tracker.setPosition(.down)
                } else {
                    parent.tracker.setPosition(.up)
                }
            }
        }
        
        private func roundTo1Dp(_ number: Float) -> Float {
            let factor = pow(10.0, Float(1))
            return (number * factor).rounded() / factor
        }
        
        private func isDeviceLyingFlat(_ acceleration: CMAcceleration) -> Bool {
            let z = acceleration.z
            
            let isValidZ = z < -0.9 && z > -1.1
            
            return isValidZ
        }
    }
}
