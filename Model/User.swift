//
//  User.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var uid: String?
    var firstName: String
    var lastName: String
    var goals: String
    var todaysRoutine: Routine
    var todaysFocuses: Focuses
    @ServerTimestamp var dateUserCreated: Timestamp?
    var isAnon: Bool
}

