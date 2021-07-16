//
//  FocusesView.swift
//  YourYogi
//
//  Created by Colm Lang on 6/24/21.
//

import SwiftUI

struct FocusesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var focusesVM = FocusesViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear  
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(focusesVM.dateString)
                        .foregroundColor(.gray)
                        .font(.subheadline )
                    Text("Today's Focuses")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                Spacer()
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Text("Cancel")
                        .foregroundColor(Color("primary"))
                    
                }
                .padding()
            }
            
            VStack(spacing: 0) {
                Text("First, how long?")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 8)
                Divider()
                
                HStack {
                    Text("I want my routine to be ")
                        .font(.callout)
                    Picker(selection: self.$focusesVM.duration, label: Text("\(self.$focusesVM.duration.wrappedValue.rawValue / 60) min.")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)) {
                        ForEach(Duration.allCases, id: \.self) { duration in
                            Text("\(duration.rawValue / 60) min.")
                        }
                    }
                    .animation(nil)
                    .pickerStyle(MenuPickerStyle())
                    .background(Color("primary").cornerRadius(8))
                }
                .padding()
            }
            .background(
                Color.white
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.5), radius: 30)
            )
            .padding()
            
            VStack(spacing: 0) {
                Text("What would you like to focus on?")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 8)
                Divider()
                
                if focusesVM.newFocusesNil {
                    Text("Add focuses from the bank below !!")
                        .font(.callout)
                        .padding(30)
                } else {
                    HStack(alignment: .bottom){
                        Spacer()
                        EditButton()
                            .padding(.horizontal)
                            .padding(.top)
                            .foregroundColor(Color("primary"))
                    }
                    ScrollViewReader{ proxy in
                        List {
                            ForEach(focusesVM.newFocuses.indices, id: \.self) { index in
                                Text("\(index + 1). \(focusesVM.newFocuses[index].rawValue)")
                                    .font(.callout)
                                    .id(index)
                                    //When a new item is added scroll to bottom
                                    .onChange(of: focusesVM.newFocuses.count, perform: { _ in
                                        withAnimation {
                                            proxy.scrollTo(focusesVM.newFocuses.count - 1, anchor: .bottom)
                                        }
                                    })
                            }
                            .onMove(perform: focusesVM.move)
                            .onDelete(perform: focusesVM.delete)
                            
                        }
                        .frame(minHeight: 50, idealHeight: UIScreen.main.bounds.height / 4)
                        .listStyle(InsetListStyle())
                        
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
                Text("Tap to add your focuses")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 8)
                Divider()
                
                ScrollView(.horizontal, showsIndicators: true){
                    HStack {
                        ForEach(Focus.allCases, id: \.self) { focus in
                            if !focusesVM.newFocuses.contains(focus) {
                                Text(focus.rawValue)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("lightText"))
                                    .padding()
                                    .animation(.spring())
                                    .background(
                                        Color("primary")
                                            .cornerRadius(15)
                                            .animation(.spring())
                                    )
                                    .onTapGesture {
                                        focusesVM.newFocuses.append(focus)
                                    }
                            }
                            
                        }
                        
                        
                    }
                    .animation(nil)
                    .padding()
                }
                
            }
            .animation(.spring())
            .background(
                Color.white
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.5), radius: 30)
                    .animation(.spring())
            )
            .padding()
            
            Spacer()
            
            
            Button(action: {
                focusesVM.setFocuses()
                presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    if focusesVM.newFocusesNil {
                        Color.gray
                            .cornerRadius(15)
                    } else {
                        Color("primary")
                            .cornerRadius(15)
                    }
                    
                    Text("Set Focuses")
                        .foregroundColor(Color("lightText"))
                        .font(.title3)
                }
                .frame(height: 50)
                .padding()
            }
            .disabled(focusesVM.newFocusesNil)
            
        }
        .foregroundColor(Color("darkNeutral"))
        
    }
}

struct FocusesView_Previews: PreviewProvider {
    static var previews: some View {
        FocusesView()
    }
}
