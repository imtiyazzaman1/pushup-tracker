//
//  TodayHistoryView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData

struct TodayHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: PushUpSet.todayPredicate(), sort: \PushUpSet.timestamp, order: .reverse)
    private var sets:[PushUpSet]
    
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        List{
            ForEach(sets) { pushUpSet in
                Text("\(dateFormatter.string(from: pushUpSet.timestamp)) - \(pushUpSet.reps)")
            }
        }
    }
}

#Preview {
    return TodayHistoryView()
        .modelContainer(PreviewDataController.previewContainer)
}
