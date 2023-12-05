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
        self.dateFormatter.dateStyle = .none
        self.dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        List {
            Section {
                ForEach(sets) { pushUpSet in
                    PushUpSetRow(set: pushUpSet)
                }
            } header: {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("\(calculateTotal())")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private func calculateTotal() -> Int {
        return sets.reduce(0) { res, pSet in
            return res + pSet.reps
        }
    }
}

#Preview {
    return TodayHistoryView(PreviewDataController.generateTodaySets())
}
