//
//  CardView.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var card: Card
    @ObservedObject var todayVM: TodayViewModel
    
    let textColor = Color("lightText")
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
            card.color2
            VStack(alignment: .leading){
                Text(card.titleText)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                if !card.expanded {Spacer()}
                Text(card.bodyText)
                    .bold()
                    .font(Font.custom("gilroy-light", size: 20))
                    .padding(card.expanded ? .bottom : .top)
                    .padding(.horizontal)
                    .padding(.bottom)
                if card.expanded{
                    CardExpansion(todayVM: todayVM, card: card)
                }
                
            }
            .foregroundColor(textColor)
                    
        }
        .animation(.spring())
        .cornerRadius(15.0)
        .frame(width: card.expanded ? UIScreen.main.bounds.width - 40 : card.cardSize, height: card.expanded ? UIScreen.main.bounds.height * 9 / 16 : card.cardSize, alignment: .center)
        .shadow(radius: 30)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
//        CardView(card: Card(id: 0, color2: Color.blue, title: "This is a test", body: "Put em up boy", z: 0.0, rotationDegs: 0.0), todayVM: TodayViewModel())
        CardPile(todayVM: TodayViewModel())
    }
}
