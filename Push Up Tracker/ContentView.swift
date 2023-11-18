//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var currentCount: Int = 0
    @State private var counts: [Int] = []
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PushUpSet.timestamp, ascending: true)],
        animation: .default)
    private var sets: FetchedResults<PushUpSet>
    
    var body: some View {
        VStack{
            Text("Press Up Tracker")
                .font(.caption)
            Text("\(currentCount)")
                .font(.title)
            
            Button(action: increment) {
                Label("add", systemImage: "plus")
            }
            
            Button("Save", action: save)
                .disabled(currentCount == 0)
            

        }
    }
    
    private func increment() {
        currentCount += 1
    }
    
    private func save() {
        currentCount = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
