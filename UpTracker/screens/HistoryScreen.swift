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
            AllHistoryView()
    }
}

#Preview {
    HistoryScreen()
        .modelContainer(PreviewDataController.previewContainer)
}
