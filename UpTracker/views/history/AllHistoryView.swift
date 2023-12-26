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
    @State private var expandedSections: Set<Date> = []
    
    @SectionedQuery(\.day, sort: \.timestamp, order: .reverse, animation: .default)
    private var sets: SectionedResults<Date, PushUpSet>
    
    private var formatter: DateFormatter
    
    init() {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "EE, dd/MM/YY"
        
    }
    
    var body: some View {
        List {
            ForEach(Array(sets.enumerated()), id: \.offset) { index, section in
                PushUpSetListSection(section.elements, title: formatter.string(from: section.id), isExpanded: index == 0)
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private func toggleSection(_ id: Date) {
        if (expandedSections.contains(id)) {
            expandedSections.remove(id)
        } else {
            expandedSections.insert(id)
        }
        
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
