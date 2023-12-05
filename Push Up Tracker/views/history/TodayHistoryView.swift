//
//  TodayHistoryView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData

struct TodayHistoryView: View {
    private let sets: [PushUpSet]
    
    private let dateFormatter: DateFormatter
    
    init(_ sets: [PushUpSet]) {
        self.sets = sets
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        List{
            ForEach(sets) { pushUpSet in
                Text("\(dateFormatter.string(from: pushUpSet.timestamp)) - \(pushUpSet.reps)")
            }
        }
    }
}

#Preview {
    return TodayHistoryView(PreviewDataController.generateTodaySets())
}
