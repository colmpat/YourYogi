//
//  Today.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Firebase

struct Today: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @StateObject var todayVM = TodayViewModel()
    @Namespace var pileID
    
    @State var scale: CGFloat = 1
    
    let headerHeight: CGFloat = 115
    let primaryWidth = UIScreen.main.bounds.width * 4 / 5
    
    @Namespace var topID
    @Namespace var cardPileID
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20.0) {
                    Spacer(minLength: 80)
                        .id(topID)
                    
                    if self.todayVM.userHasFocuses {
                        CardPile(todayVM: self.todayVM)
                            .padding(.bottom)
                            .id(cardPileID)
                        Button(action: {
                            todayVM.showFocuses.toggle()
                        }) {
                            ZStack {
                                Color("pastelBlue")
                                    .cornerRadius(15)
                                Text("Tap here to update today's focuses")
                                    .font(.title3)
                                    .padding(.vertical)
                                    .padding()
                            }
                            .foregroundColor(Color("lightText"))
                            
                        }
                        .padding()
                        .shadow(radius: 30)
                        
                        
                    } else {
                        Button(action: {
                            todayVM.showFocuses.toggle()
                        }) {
                            ZStack {
                                Color("pastelBlue")
                                    .cornerRadius(15)
                                VStack {
                                    Text("What would you like to focus on today?")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                        .padding(.horizontal)
                                        .padding(.top)
                                    Divider()
                                        .padding(.horizontal)
                                    Text("Tap here to set today's focuses.")
                                        .font(.title3)
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                }
                            }
                            .foregroundColor(Color("lightText"))
                        }
                        .padding()
                        .shadow(radius: 30)
                        
                        CardPile(todayVM: todayVM)
                            .padding(.vertical)
                            .id(cardPileID)
                        
                    }
                    
                    Spacer(minLength: 80)
                }
                .onReceive(todayVM.$scroll, perform: { _ in
                    withAnimation(.easeInOut){
                        proxy.scrollTo(cardPileID, anchor: .center)
                    }
                })
                
            }
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $todayVM.showFocuses){
                FocusesView()
                    .background(BackgroundBlurView().ignoresSafeArea())
            }
        }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialLight))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}
