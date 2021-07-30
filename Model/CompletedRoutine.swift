//
//  CompletedRoutine.swift
//  YourYogi
//
//  Created by Colm Lang on 7/15/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CompletedRoutine: Codable, Hashable {
    static func == (lhs: CompletedRoutine, rhs: CompletedRoutine) -> Bool {
        return lhs.dateCompleted == rhs.dateCompleted
    }
    
    let exercises: [Exercise]
    let completed: [Bool]
    let notes: String?
    
    var uid: String?
    @ServerTimestamp var dateCompleted: Timestamp?
}
