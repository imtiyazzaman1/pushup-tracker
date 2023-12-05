//
//  PushUpSetList.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 05/12/2023.
//

import SwiftUI

struct PushUpSetList: View {
    private let sets: [PushUpSet]
    private let title: String
    
    private let dateFormatter: DateFormatter
    
    init(_ sets: [PushUpSet]) {
        self.init(sets, title: "Total")
    }
    
    init(_ sets: [PushUpSet], title: String) {
        self.sets = sets
        self.title = title
        
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
                    Text(title)
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
    PushUpSetList(PreviewDataController.generateTodaySets())
}
