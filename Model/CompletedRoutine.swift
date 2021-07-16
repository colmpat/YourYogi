//
//  CompletedRoutine.swift
//  YourYogi
//
//  Created by Colm Lang on 7/15/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CompletedRoutine: Codable {
    let exercises: [Exercise]
    let completed: [Bool]
    let notes: String?
    
    var uid: String?
    @ServerTimestamp var dateCompleted: Timestamp?
}
