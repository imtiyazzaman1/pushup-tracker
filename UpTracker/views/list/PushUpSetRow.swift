//
//  PushUpSetRow.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 05/12/2023.
//

import SwiftUI

struct PushUpSetRow: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    let set: PushUpSet
    
    var body: some View {
        HStack {
            Text("\(PushUpSetRow.dateFormatter.string(from: set.timestamp))")
            Spacer()
            Text("\(set.reps)")
        }
    }
}

#Preview {
    PushUpSetRow(set: PreviewDataController.generateTodaySets().first!)
}
