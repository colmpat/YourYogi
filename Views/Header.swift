//
//  Header.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI

struct Header: View {
    @ObservedObject var homeVM: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let textColor = Color("lightText")
    var body: some View {
        ZStack(alignment: self.homeVM.showMenu ? .top : .bottom) {
            LinearGradient(
                gradient:
                    Gradient(
                        colors: [Color("primary"),
                                 Color("\(colorScheme == .dark ? "dark" : "light")Accent")
                        ]),
                startPoint: .trailing,
                endPoint: .topLeading
            )
            
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Button(action: {
                        self.homeVM.toggleMenu()
                    }, label: {
                        Image(systemName: !self.homeVM.showMenu ? "line.horizontal.3" : "chevron.down")
                            .padding()
                            .scaleEffect(1.1)
                            .rotationEffect(.degrees(self.homeVM.showMenu ? 360 : 0))
                            .animation(.easeInOut(duration: 0.3))
                    })
                    Spacer()
                    Text(self.homeVM.today)
                        .fontWeight(.semibold)
                        .font(.title2)
                }
                .padding(.horizontal)
                
                if self.homeVM.showMenu {
                    Tabs(homeVM: self.homeVM)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))
                }
                
            }
            .foregroundColor(textColor)
            .offset(y: self.homeVM.showMenu ? 40 : 0)
            
        }
        .cornerRadius(radius: 30, corners: .bottomLeft)
        .frame(height: self.homeVM.showMenu ? UIScreen.main.bounds.height : 90)
    }
}
struct Tabs: View {
    
    @ObservedObject var homeVM: HomeViewModel
    
    let tabs = Tab.allCases
    
    var body: some View {
        ForEach(0..<self.tabs.count){ index in
            Button(action: { homeVM.pressTab(tab: self.tabs[index]) }) {
                Text(tabs[index].rawValue)
                    .fontWeight(.semibold)
                    .animation(.ripple(index: index).delay(0.25))
                    .font(.title)
                    .animation(.none)
                    .padding(.leading)
            }
            
            
        }
        .padding(.leading)
        .padding(.top)
    }
}

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.7)
            .speed(1.5)
            .delay((0.07) * Double(index))
    }
}

//Allows for corner specification in .cornerRadius()
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
