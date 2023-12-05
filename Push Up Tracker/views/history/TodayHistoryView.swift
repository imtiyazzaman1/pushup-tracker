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
    
    init(_ sets: [PushUpSet]) {
        self.sets = sets
    }
    
    var body: some View {
        PushUpSetList(sets)
    }
}

#Preview {
    return TodayHistoryView(PreviewDataController.generateTodaySets())
}
