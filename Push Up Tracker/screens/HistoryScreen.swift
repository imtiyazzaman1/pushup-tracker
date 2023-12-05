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
    
    var body: some View {
        TabView(selection: $historyIndex) {
            TodayHistoryView()
                .tabItem { Text("Today") }
                .tag(0)
            AllHistoryView()
                .tabItem { Text("All") }
                .tag(1)
            // Add more views as needed
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    HistoryScreen()
        .modelContainer(PreviewDataController.previewContainer)
}
