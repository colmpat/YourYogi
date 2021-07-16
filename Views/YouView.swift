//
//  YouView.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Combine
import Firebase

struct YouView: View {
    
    @ObservedObject var homeVM: HomeViewModel
    
    @StateObject var YouVM = YouViewModel()
    
    @State private var showLogInScreen: Bool
    @State private var coordinator: SignInWithAppleCoordinator?
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        self.showLogInScreen = false
    }
    
    var body: some View {
        ZStack {
            if !YouVM.anonymous {
                //show user info
                VStack {
                    Text("Name: \(self.homeVM.user!.firstName) \(self.homeVM.user!.lastName)")
                        .font(.largeTitle)
                    Text("Goals: \n\(self.homeVM.user!.goals)")
                        .font(.callout)
                        .padding()
                    Text("Today's Main Focus: \n\(self.homeVM.user!.todaysFocuses.focuses.first?.rawValue ?? "none" )\nSet on: \(self.homeVM.user!.todaysFocuses.dateGenerated ?? Timestamp())")
                        .font(.callout)
                        .padding()
                    
                    Button(action: {try? Auth.auth().signOut()}) {
                        Text("Sign Out")
                            .fontWeight(.semibold)
                            .font(.callout)
                            .padding()
                            .background(Color("primary").cornerRadius(10))
                            .frame(height: 50)
                    }
                    .padding()
                }
                
            } else {
                VStack(alignment: .center){
                    VStack {
                        Text("You are not logged in! You can log in or sign up here to maximize YourYogi's benefits!")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {self.showLogInScreen.toggle()}){
                            ZStack {
                                Color("darkAccent")
                                    .cornerRadius(15)
                                Text("Sign In Now")
                                    .fontWeight(.semibold)
                                    .font(.callout)
                            }
                            .frame(height: 50)
                        }
                        .padding()
                    }
                    .foregroundColor(Color("lightText"))
                    .background(Color("primary").cornerRadius(15))
                    .padding(30)
                    
                    Text("— OR —")
                    SignInWithAppleButton()
                        .frame(height: 50)
                        .onTapGesture {
                            self.coordinator = SignInWithAppleCoordinator()
                            if let coordinator = self.coordinator {
                                coordinator.startSignInWithAppleFlow {
                                    print("You successfully signed in")
                                }
                            }
                        }
                        .padding(30)
                    
                }
                
            }
        }
        .fullScreenCover(isPresented: self.$showLogInScreen) {
            LogInView()
        }
        
    }
}
