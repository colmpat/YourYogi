//
//  Card.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI

class Card: ObservableObject, Identifiable {
    
    let id: Int
    let color2: Color
    let titleText: String
    let bodyText: String
    let cardSize: CGFloat
    
    @Published var z: Double
    @Published var rotationDegs: Double = 0
    @Published var expanded: Bool
    
    init(id: Int, color2: Color, title: String, body: String, z: Double, rotationDegs: Double) {
        self.id = id
        self.color2 = color2
        self.titleText = title
        self.bodyText = body
        self.z = z
        self.rotationDegs = rotationDegs
        self.cardSize = 4 / 5 * UIScreen.main.bounds.width
        self.expanded = false
    }
    
    
    
    func getDeg() -> Double {
        switch self.z {
            case -1.0:
                return -14.0
            case 0.0:
                return -7.0
            default:
                return 0.0
        }
    }
    
    func newZ() {
        if self.z == 1.0 {
            self.z = -1.0
        }
        else {
            self.z += 1
        }
        self.rotationDegs = getDeg()
    }
    
    func getOffset(dragAmount: CGSize) -> CGSize {
        switch self.z {
            case 1.0:
                return dragAmount
            case 0.0:
                return CGSize(width: -0.12 * dragAmount.width, height: -0.12 * dragAmount.height)
            default:
                return CGSize(width: -0.3 * dragAmount.width, height: -0.3 * dragAmount.height)
        }
    }
}
