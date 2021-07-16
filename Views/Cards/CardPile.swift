//
//  CardPile.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI

struct CardPile: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @StateObject var cardPileVM = CardPileViewModel()
    @ObservedObject var todayVM: TodayViewModel
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(cardPileVM.cards) { card in
                    CardView(card: card, todayVM: todayVM)
                        .animation(.spring())
                        .offset(card.getOffset(dragAmount: cardPileVM.dragAmount))
                        .rotationEffect(.degrees(card.rotationDegs))
                        .animation(.spring().speed(0.8))
                        .zIndex(card.z)
                        .gesture(DragGesture()
                                    .onChanged({(value) in
                                        if !card.expanded {
                                            cardPileVM.dragAmount = CGSize(width: value.translation.width, height: value.translation.height / 2)
                                        }
                                    })
                                    .onEnded({(value) in
                                        cardPileVM.dragEnd(card: card)
                                    })
                        )
                        .onTapGesture {
                            
                            if card.id == cardPileVM.currentIndex {
                                if !cardPileVM.cards[cardPileVM.currentIndex].expanded {
                                    self.todayVM.scroll.toggle()
                                }
                                withAnimation(.easeOut){
                                    card.expanded.toggle()
                                }
                                
                            }
                        }
                }
            }
            .zIndex(1.0)
            .padding(.top)
            HStack(spacing: 0){
                ForEach(0..<3) { index in
                    Image(systemName: cardPileVM.currentIndex == index ? "circle.fill" : "circle")
                        .scaleEffect(0.5)
                }
                
            }
            .zIndex(0.0)
            .padding(.top)
            
        }
    }
}

struct CardPile_Previews: PreviewProvider {
    static var previews: some View {
        CardPile(todayVM: TodayViewModel())
    }
}
