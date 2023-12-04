//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            TrackingView()
                .tag(0)
            HistoryScreen()
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: PushUpSet.self, configurations: config)
    
    for i in 1..<10 {
        let set = PushUpSet(i)
        container.mainContext.insert(set)
    }
    
    return ContentView()
        .modelContainer(container)
}
