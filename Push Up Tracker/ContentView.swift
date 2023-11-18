//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var currentCount: Int64 = 0
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PushUpSet.timestamp, ascending: true)],
        animation: .default)
    private var sets: FetchedResults<PushUpSet>
    
    private let dateFormatter = DateFormatter()
   
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    var body: some View {
        VStack{
            Text("Press Up Tracker")
                .font(.caption)
            Text("\(currentCount)")
                .font(.title)
            
            Button(action: { currentCount += 1 }) {
                Label("add", systemImage: "plus")
            }
            
            Button("Save", action: save)
                .disabled(currentCount == 0)
            
            List{
                ForEach(sets) { pushUpSet in
                    Text("\(dateFormatter.string(from: pushUpSet.timestamp!)) - \(pushUpSet.reps)")
                }
            }

        }
    }
    
    private func save() {
        let p = PushUpSet(context: viewContext)
        p.timestamp = Date()
        p.reps = currentCount
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                currentCount = 0
            }
            catch {
                abort()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
