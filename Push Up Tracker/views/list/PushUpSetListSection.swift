//
//  PushUpSetListSection.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 07/12/2023.
//

import SwiftUI

struct PushUpSetListSection: View {
    @State var isExpanded: Bool
    var isTogglable: Bool
    
    private let sets: [PushUpSet]
    private let title: String
    private let dateFormatter: DateFormatter
    
    init(_ sets: [PushUpSet]) {
        self.init(sets, title: "Total", isExpanded: true, isTogglable: false)
    }
    
    init(_ sets: [PushUpSet], isTogglable: Bool) {
        self.init(sets, title: "Total", isExpanded: true, isTogglable: isTogglable)
    }
    
    init(_ sets: [PushUpSet], isExpanded: Bool) {
        self.init(sets, title: "Total", isExpanded: isExpanded, isTogglable: true)
    }
    
    init(_ sets: [PushUpSet], title: String, isExpanded: Bool) {
        self.init(sets, title: title, isExpanded: isExpanded, isTogglable: true)
    }
    
    init(_ sets: [PushUpSet], title: String, isExpanded: Bool, isTogglable: Bool) {
        self.sets = sets
        self.title = title
        self.isExpanded = isExpanded
        self.isTogglable = isTogglable
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .none
        self.dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        Section {
            if (isExpanded) {
                ForEach(sets) { pushUpSet in
                    PushUpSetRow(set: pushUpSet)
                }
            }
        } header: {
            if (isTogglable) {
                HStack {
                    Text(title)
                    Spacer()
                    Text("\(calculateTotal())")
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .onTapGesture(perform: toggleExpand)
            } else {
                HStack {
                    Text(title)
                    Spacer()
                    Text("\(calculateTotal())")
                }
            }
        }
    }
    
    private func toggleExpand() {
        isExpanded = isExpanded ? false : true
    }
    
    private func calculateTotal() -> Int {
        return sets.reduce(0) { res, pSet in
            return res + pSet.reps
        }
    }
}

#Preview {
    List {
        PushUpSetListSection(PreviewDataController.generateTodaySets())
    }
    .scrollContentBackground(.hidden)
}
