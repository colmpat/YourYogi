//
//  RoutineView.swift
//  YourYogi
//
//  Created by Colm Lang on 7/13/21.
//

import SwiftUI

struct RoutineView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var routineVM = RoutineViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                
                //Exit screen after routine is complete (tag use is to allow access to exit case from many places, not just by clicking on the button)
                NavigationLink(
                    destination: RoutineExitView(routineVM: routineVM),
                    tag: 1,
                    selection: $routineVM.doneSelection,
                    label: {EmptyView()}
                )
                
                
                RoutineProgress(routineVM: routineVM)
                
                Text("\(routineVM.minutes):\(routineVM.seconds < 10 ? "0" : "")\(routineVM.seconds)")
                    .fontWeight(.semibold)
                    .foregroundColor(routineVM.showButtons ? Color("darkAccent") : Color("lightAccent"))
                    .font(.title)
                
                Spacer()
                ZStack {
                    ForEach(routineVM.exercises.indices) { index in
                        ExerciseCard(
                            index: index,
                            exercise: routineVM.exercises[index],
                            routineVM: routineVM
                        )
                    }
                }
                Spacer()
                
                Button(action: {
                    routineVM.next()
                }) {
                    ZStack {
                        Color("\(colorScheme == .dark ? "light" : "dark")Accent")
                            .cornerRadius(15)
                            .frame(maxHeight: 60)
                            .padding(.horizontal)
                            
                        Text("Skip Exercise")
                            .foregroundColor(Color("lightText"))
                            .font(.title3)
                            .bold()
                    }
                }
                .disabled(!routineVM.showButtons)
                .opacity(routineVM.showButtons ? 1.0 : 0.0)
                
                Button(action: {
                    routineVM.doneSelection = 1
                }) {
                    Text("Finish Early")
                        .font(.body)
                        .foregroundColor(
                            colorScheme == .dark ? Color("lightNeutral") : Color("darkAccent")
                        )
                        .padding()
                }
                .disabled(!routineVM.showButtons)
                .opacity(routineVM.showButtons ? 1.0 : 0.0)
                
            }
            .background(
                Color("lightNeutral")
                    .ignoresSafeArea()
            )
            .fullScreenCover(isPresented: $routineVM.showSnapshot) {
                Snapshot(routineVM: routineVM)
                    .background(
                        BackgroundBlurView()
                            .ignoresSafeArea()
                    )
            }
            .onTapGesture{
                //if not showing buttons then show for 5 seconds
                if !routineVM.showButtons {
                    withAnimation {
                        routineVM.showButtons.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            routineVM.showButtons.toggle()
                        }
                    }
                }
            }
            .transition(.slide)
            .navigationBarHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
