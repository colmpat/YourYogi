//
//  Snapshot.swift
//  YourYogi
//
//  Created by Colm Lang on 7/13/21.
//

import SwiftUI

struct Snapshot: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var routineVM: RoutineViewModel
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(routineVM.dateString)
                        .foregroundColor(.gray)
                        .font(.subheadline )
                    Text("Today's Routine")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                Spacer()
            }
            Divider()
            
            ScrollView(showsIndicators: false){
                
                VStack(spacing: 13){
                    ForEach(routineVM.exercises.indices) { index in
                        HStack {
                            Image(systemName: "circle.fill")
                                .scaleEffect(0.5)
                                .foregroundColor(Color("primary"))
                            Text(routineVM.exercises[index].name)
                                .fontWeight(.bold)
                                .font(.title3)
                            Spacer()
                            Text(routineVM.durationString(duration: routineVM.exercises[index].duration_secs))
                                .fontWeight(.semibold)
                                .font(.callout)
                                
                        }
                        if index != routineVM.exercises.count - 1 {
                            Divider()
                        }
                    }
                    
                }
                .padding()
                .background(
                    Color.white
                        .cornerRadius(10)
                        .shadow(radius: 20)
                )
                .padding()
                .padding(.vertical)
            }
            
            
            Divider()
            Button(action: {
                //begin countdown
                
                //dismiss
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
                
                //hide buttons after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        routineVM.showButtons.toggle()
                    }
                }
                
            }) {
                ZStack {
                    Color("primary")
                        .cornerRadius(15)
                
                    Text("Begin")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("lightText"))
                        .font(.title3)
                }
                .frame(height: 50)
                .padding()
            }
            
        }
        .foregroundColor(Color("darkNeutral"))
    }

}

struct Snapshot_Previews: PreviewProvider {
    static var previews: some View {
        Snapshot(routineVM: RoutineViewModel())
    }
}
