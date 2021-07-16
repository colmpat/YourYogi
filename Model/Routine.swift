//
//  Routine.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Routine: Codable {
    var exercises: [Exercise] 
    @ServerTimestamp var dateGenerated: Timestamp?
}
