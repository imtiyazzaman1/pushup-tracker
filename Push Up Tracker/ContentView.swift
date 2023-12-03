//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PushUpSet.timestamp, ascending: true)],
        animation: .default)
    private var sets: FetchedResults<PushUpSet>
    
    @StateObject private var tracker: StatefulTracker = StatefulTracker()
    
    @State private var isTracking = false
    @State private var total: Int64 = 0
    
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
                    Text("\(dateFormatter.string(from: pushUpSet.timestamp!)) - \(pushUpSet.reps)")
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
        let p = PushUpSet(context: viewContext)
        p.timestamp = Date()
        p.reps = tracker.count
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                calculateTotal()
            }
            catch {
                abort()
            }
        }
    }
    
    private func calculateTotal() {
        self.total = sets.reduce(0, { (res: Int64, pushUpSet: PushUpSet) -> Int64 in
            return res + pushUpSet.reps
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
