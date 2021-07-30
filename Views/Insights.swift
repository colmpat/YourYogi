//
//  History.swift
//  YourYogi
//
//  Created by Colm Lang on 7/4/21.
//

import SwiftUI

struct Insights: View {
    @StateObject var insightsVM = InsightsViewModel()
    let dateFormatter = DateFormatter()
    
    @Namespace var namespace
    @State var showPopUp = false
    
    init() {
        dateFormatter.dateFormat = "MMM dd."
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false){
                Spacer(minLength: 80)
                VStack(alignment: .leading, spacing: 9) {
                    if insightsVM.noRoutines {
                        Text("You haven't completed any routines yet. Do YourYogi's curated routine for today then check back !")
                    } else {
                        ForEach(insightsVM.routinesByYear, id: \.self) { year in
                            Text(year.year)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .zIndex(0)
                            
                            ForEach(year.monthsAndRoutines, id: \.self) { month in
                                Text(month.month)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .zIndex(0)
                                
                                ForEach(month.datesAndRoutines, id: \.self) { date in
                                    Text(dateFormatter.string(from: date.date))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .zIndex(0)
                                    VStack(spacing: 15){
                                        ForEach(date.routines, id: \.self) { routine in
                                            CompletedRoutineCell(routine: routine, namespace: namespace)
                                                .onTapGesture {
                                                    insightsVM.selectedRoutine = routine
                                                    withAnimation(.spring()) {
                                                        self.showPopUp.toggle()
                                                    }
                                                }
                                                .zIndex(routine.hashValue == insightsVM.selectedRoutine?.hashValue ? 1 : -1)
                                        }
                                    }
                                    .padding(.bottom, 10)
                                    

                                }
                                .padding(.leading, 8)
                                
                                
                            }
                            .padding(.leading, 8)
                            
                        }
                    }
                }
                .padding()
                .foregroundColor(Color("darkNeutral"))
                .background(Color("lightNeutral").ignoresSafeArea())
                
            }
            .zIndex(-1)
            
            if showPopUp && insightsVM.selectedRoutine != nil {
                CompletedRoutineCard(routine: insightsVM.selectedRoutine!, namespace: namespace, expanded: $showPopUp, date: dateFormatter.string(from: insightsVM.selectedRoutine!.dateCompleted?.dateValue() ?? Date()))
                    .zIndex(1)
            }
        }
        
        
        
        
    }
}

struct Insights_Previews: PreviewProvider {
    static var previews: some View {
        Insights()
    }
}
