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
    
    @State var notes = ""
    @State var placeholder = "Today's routine felt..."
    
    init(routineVM: RoutineViewModel) {
        self.routineVM = routineVM
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(spacing: 0) {
                        Text("Finishing Thoughts")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 8)
                        Divider()
                        
                        ZStack(alignment: .leading) {
                            if notes.isEmpty {
                                TextEditor(text: $placeholder)
                                    .font(.body)
                                    .padding(.vertical)
                                    .foregroundColor(.gray)
                                    .disabled(true)
                            }
                            
                            TextEditor(text: $notes)
                                .font(.body)
                                .padding(.vertical)
//                                .opacity(notes.isEmpty ? 0.25 : 1)
                                
                        }
                        .padding()
                        
                    }
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .animation(.spring())

                    )
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        Text("Completed")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 8)
                        Divider()
                        
                        VStack {
                            ForEach(routineVM.exercises.indices) { index in
                                if routineVM.completed[index] {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .scaleEffect(0.5)
                                            .foregroundColor(Color("primary"))
                                        Text(routineVM.exercises[index].name)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color("primary"))
                                            
                                    }
                                    if index != routineVM.exercises.count - 1 {
                                        Divider()
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                        
                    }
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .animation(.spring())

                    )
                    .padding()
                    
                    VStack(spacing: 9) {
                        Text("Not Completed")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 8)
                        Divider()
                        
                        VStack {
                            ForEach(routineVM.exercises.indices) { index in
                                if !routineVM.completed[index] {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .scaleEffect(0.5)
                                            .foregroundColor(Color("primary"))
                                        Text(routineVM.exercises[index].name)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                        Spacer()
                                    }
                                    if index != routineVM.exercises.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        
                    }
                    
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .animation(.spring())

                    )
                    .padding(.horizontal)
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
                                notes: notes.isEmpty ? nil : notes,
                                uid: Auth.auth().currentUser?.uid
                            )
                        //write data to routines
                        RoutineRepository.shared.addRoutine(completedRoutine)
                        //change view
                        homeVM.home = true
                    }) {
                        Text("Finish")
                            .padding()
                    }
            )
        }
        .navigationBarHidden(true)
        .accentColor(Color("primary"))
    }
}

struct RoutineExitView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExitView(routineVM: RoutineViewModel())
    }
}
