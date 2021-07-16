//
//  Home.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        if homeVM.home {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color("lightNeutral")
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        switch self.homeVM.currentTab {
                        case .today:
                            Today().environmentObject(homeVM)
                        case .focuses:
                            Text("Focuses")
                        case .settings:
                            Text("Settings")
                        case .you:
                            YouView(homeVM: self.homeVM)
                        }
                        Spacer()
                    }
                    
                    
                    Header(homeVM: self.homeVM)
                        .ignoresSafeArea(edges: .top)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        else {
            RoutineView().environmentObject(homeVM)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
