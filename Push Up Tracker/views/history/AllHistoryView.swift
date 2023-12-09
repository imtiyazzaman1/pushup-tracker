//
//  AllHistoryView.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 03/12/2023.
//

import SwiftUI
import SwiftData
import SectionedQuery

struct AllHistoryView: View {
    @SectionedQuery(\.day, sort: \.timestamp, order: .reverse, animation: .default)
    private var sets: SectionedResults<Date, PushUpSet>
    
    private var formatter: DateFormatter
    
    init() {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "EE, dd/MM/YY"
    }
    
    var body: some View {
        List(sets) { section in
            Section {
                ForEach(section) { set in
                    PushUpSetRow(set: set)
                }
            } header: {
                HStack {
                    Text(formatter.string(from: section.id))
                    Spacer()
                    Text("\(calculateTotal(section.elements))")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private func calculateTotal(_ sets: [PushUpSet]) -> Int {
        return sets.reduce(0) { res, pSet in
            return res + pSet.reps
        }
    }
}

#Preview {
    AllHistoryView()
        .modelContainer(PreviewDataController.previewContainer)
}
