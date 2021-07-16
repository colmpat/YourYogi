//
//  Focuses.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Focuses: Codable {
    var focuses: [Focus]
    var duration: Duration = .ten
    @ServerTimestamp var dateGenerated: Timestamp?
    
}

enum Focus: String, Codable, CaseIterable {
    case neck = "Neck", upperBack = "Upper Back", lowerBack = "Lower Back", shoulder = "Shoulders", hips = "Hips", balance = "Balance", flexibility = "Flexibility", strength = "Strength", recovery = "Recovery", energy = "Energy"
}

enum Duration: Int, Codable, CaseIterable {
    case five = 300, ten = 600, fifteen = 900, twenty = 1200
}
