//
//  CardExpansion.swift
//  YourYogi
//
//  Created by Colm Lang on 7/13/21.
//

import SwiftUI

struct CardExpansion: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @ObservedObject var todayVM: TodayViewModel
    @ObservedObject var card: Card
    var body: some View {
        switch card.id {
        case 0:
            YogiCardExpansion(todayVM: todayVM, card: card)
        default:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
    }
}
struct YogiCardExpansion: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @ObservedObject var todayVM: TodayViewModel
    @ObservedObject var card: Card
    
    let textColor = Color("lightText")
    var body: some View {
        if todayVM.userHasFocuses {
            //The user must have a routine
            VStack(alignment: .leading){
                ForEach(0..<4) { index in
                    HStack {
                        Image(systemName: "circle.fill")
                            .scaleEffect(0.5)
                        Text((index == 3 ? "and more..." : todayVM.user?.todaysRoutine.exercises[index].name)!)
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .foregroundColor(textColor)
                    .animation(.ripple(index: index).delay(0.5))
                    
                }
                .padding(.leading)
                
            }
            .transition(.slideThenShrink)
            
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    homeVM.home.toggle()
                }, label: {
                    Text("Start!")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .padding()
                        .padding(.horizontal)
                        .foregroundColor(textColor)
                        .background(Color("pastelRed"))
                        .cornerRadius(10)
                })
                .padding(40)
                Spacer()
            }
            .transition(.scale)
        } else {
            //The user must first set focuses
            Spacer()
            VStack{
                VStack {
                    Text("You must set today's focuses before YourYogi can recommend a routine.")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                }
                .animation(.spring().delay(0.2))
                
                HStack {
                    Spacer()
                    Button(action: {
                        todayVM.showFocuses.toggle()
                    }) {
                        Text("Set Today's Focuses !")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .padding()
                            .padding(.horizontal)
                            .background(Color("pastelRed"))
                            .cornerRadius(10)
                            
                    }
                    .padding()
                    Spacer()
                }
                .animation(.spring().delay(0.4))
                
            }
            //.transition(.slideThenShrink)
            .foregroundColor(textColor)
            
            
            .background(
                Color("darkAccent")
                    .cornerRadius(10)
            )
            .padding()
            
            Spacer()
        }
    }
}

extension AnyTransition {
    static var slideThenShrink: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .scale)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
