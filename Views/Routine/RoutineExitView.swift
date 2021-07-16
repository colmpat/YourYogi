//
//  RoutineExitView.swift
//  YourYogi
//
//  Created by Colm Lang on 7/16/21.
//

import SwiftUI
import Firebase

struct RoutineExitView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @ObservedObject var routineVM: RoutineViewModel
    
    @State var notes: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(spacing: 0) {
                        Text("Completed")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 8)
                        Divider()
                        
                        ForEach(routineVM.exercises.indices) { index in
                            if routineVM.completed[index] {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .scaleEffect(0.5)
                                        .foregroundColor(Color("primary"))
                                    Text(routineVM.exercises[index].name)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("primary"))
                                    
                                }
                            }
                        }
                        
                    }
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .animation(.spring())

                    )
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        Text("Not Completed")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 8)
                        Divider()
                        
                        ForEach(routineVM.exercises.indices) { index in
                            if !routineVM.completed[index] {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .scaleEffect(0.5)
                                        .foregroundColor(Color("primary"))
                                    Text(routineVM.exercises[index].name)
                                    
                                    Spacer()
                                    
                                }
                            }
                        }
                        
                    }
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .animation(.spring())

                    )
                    .padding()
                }
                .foregroundColor(Color("darkNeutral"))
            }
            .background(
                Color("lightNeutral")
                    .ignoresSafeArea()
            )
            .navigationBarItems(
                leading: EmptyView(),
                trailing:
                    Button(action: {
                        let completedRoutine =
                            CompletedRoutine(
                                exercises: routineVM.exercises,
                                completed: routineVM.completed,
                                notes: notes,
                                uid: Auth.auth().currentUser?.uid
                            )
                        //write data to routines
                        RoutineRepository.shared.addRoutine(completedRoutine)
                        //change view
                        homeVM.home = true
                    }) {
                        Text("Exit")
                            .padding()
                    }
            )
        }
        .navigationBarHidden(true)
    }
}

struct RoutineExitView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExitView(routineVM: RoutineViewModel())
    }
}
