//
//  Exercise.swift
//  YourYogi
//
//  Created by Colm Lang on 6/24/21.
//

import Foundation

struct Exercise: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var desc: String
    var duration_secs: Int
    var vals: [Int]
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
