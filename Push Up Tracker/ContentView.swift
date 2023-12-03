//
//  ContentView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TrackingView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PushUpSet.self, inMemory: true)
}
