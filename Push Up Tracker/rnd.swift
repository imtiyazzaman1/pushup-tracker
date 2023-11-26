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
    
    @State private var pushUpCount = 0
    @State private var isTracking = false
    @State private var zPosition: Float = 0

    var body: some View {
        VStack {
            Text("Push-Up Counter")
                .font(.largeTitle)

            Text("\(pushUpCount)")
                .font(.system(size: 100))
                .fontWeight(.bold)
            
            Text("\(zPosition)")

            Button(isTracking ? "Stop Tracking" : "Start Tracking") {
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
            
            ARFaceTrackingView(pushUpCount: $pushUpCount,  zPosition: $zPosition, arView: arView)
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
    @Binding var pushUpCount: Int
    @Binding var zPosition: Float
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
        var lastKnownZPosition: Float?

        init(_ parent: ARFaceTrackingView) {
            self.parent = parent
        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
            let z = faceAnchor.transform.columns.3.z
            
            parent.zPosition = z
            
            print(z)

            // Implement the logic to count push-ups based on the z-position changes
            // Update parent.pushUpCount as needed
        }
    }
}



struct RnDView_Previews: PreviewProvider {
    static var previews: some View {
        RnDView()
    }
}
