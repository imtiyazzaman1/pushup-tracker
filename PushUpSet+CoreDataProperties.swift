//
//  PushUpSet+CoreDataProperties.swift
//  Push Up Tracker
//
//  Created by Imtiyaz Zaman on 04/11/2023.
//
//

import Foundation
import CoreData


extension PushUpSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PushUpSet> {
        return NSFetchRequest<PushUpSet>(entityName: "PushUpSet")
    }

    @NSManaged public var reps: Int64
    @NSManaged public var timestamp: Date?

}

extension PushUpSet : Identifiable {

}
