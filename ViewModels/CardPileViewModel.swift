//
//  CardPileViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI

class CardPileViewModel: ObservableObject {
    
    @Published var dragAmount = CGSize.zero
    @Published var currentIndex = 0
    
    var cards: [Card] = [
        Card(
            id: 0,
            color2: Color("primary"),
            title: "Today's Routine",
            body: "Try Your Yogi's curated routine for today !",
            z: 1.0,
            rotationDegs: 0.0),
        Card(
            id: 1,
            color2: Color("pastelBlue"),
            title: "Your Saved Routines",
            body: "Do one of your saved routines.",
            z: 0.0,
            rotationDegs: -7.0),
        Card(
            id: 2,
            color2: Color("lightAccent"),
            title: "Create a Routine",
            body: "Chose from hundreds of poses to make a routine you love.",
            z: -1.0,
            rotationDegs: -14.0)
    ]
    
    

    func setZs() {
        for card in self.cards {
            card.newZ()
        }
    }
    
    func dragEnd(card: Card) {
        if draggedEnough(){
            
            withAnimation(.spring()){
                self.setZs()
                if card.expanded {
                    card.expanded.toggle()
                }
                self.currentIndex = (self.currentIndex + 1) % 3
            }
            
        }
        withAnimation(.spring(response: 1)){
            self.dragAmount = .zero
        }
        
    }
    
    private func draggedEnough() -> Bool {
        let size = self.dragAmount
        let needed = UIScreen.main.bounds.width * 2 / 7
        return size.height > needed || size.height < -needed || size.width > needed || size.width < -needed
    }
    
}
