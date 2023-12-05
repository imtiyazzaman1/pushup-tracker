//
//  HistoryView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData

struct HistoryScreen: View {
    @State private var historyIndex = 0
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: PushUpSet.todayPredicate(), sort: \PushUpSet.timestamp, order: .reverse)
    private var todaysSets:[PushUpSet]
    @State private var total: Int = 0
    
    var body: some View {
        TabView(selection: $historyIndex) {
            TodayHistoryView(todaysSets)
                .tabItem { Text("Today (\(total))") }
                .tag(0)
            AllHistoryView()
                .tabItem { Text("All") }
                .tag(1)
            // Add more views as needed
        }
        .tabViewStyle(DefaultTabViewStyle())
        .onAppear(perform: {
            total = todaysSets.reduce(0) { res, current in
                res + current.reps
            }
        })
        
    }
}

#Preview {
    HistoryScreen()
        .modelContainer(PreviewDataController.previewContainer)
}
