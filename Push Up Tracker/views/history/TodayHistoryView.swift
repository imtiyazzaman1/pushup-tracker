//
//  TodayHistoryView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData

struct TodayHistoryView: View {
    @Query(filter: PushUpSet.todayPredicate(), sort: \PushUpSet.timestamp, order: .reverse)
    private var sets:[PushUpSet]
    
    var body: some View {
        List {
            PushUpSetListSection(sets)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    TodayHistoryView()
        .modelContainer(PreviewDataController.previewContainer)
}
