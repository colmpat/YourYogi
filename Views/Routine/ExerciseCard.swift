//
//  ExerciseCard.swift
//  YourYogi
//
//  Created by Colm Lang on 7/14/21.
//

import SwiftUI

struct ExerciseCard: View {
    
    let index: Int
    let exercise: Exercise
    @ObservedObject var routineVM: RoutineViewModel
    
    let cardWidth = UIScreen.main.bounds.width * 4/5
    
    var progress: Double {
        return timeOnCurrentCard / Double(exercise.duration_secs)
    }
    @State var timeOnCurrentCard = 0.0
    
    var body: some View {
        VStack {
            HStack(alignment: .top){
                Text(exercise.name)
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button(action: {
                    if routineVM.currentIndex == index {
                        routineVM.paused.toggle()
                    }
                }, label: {
                    Image(systemName: "info.circle.fill")
                })
                .padding()
            }
            Spacer()
            Image(systemName: "leaf.fill")
                .scaleEffect(5.0)
            Spacer()
            HStack{
                Spacer()
                Text(routineVM.durationString(duration: exercise.duration_secs))
                    .font(.body)
                    .padding(.trailing)
            }
            ProgressView(value: progress)
                .padding([.horizontal, .bottom], 15.0)
                .progressViewStyle(LinearProgressViewStyle())
                .accentColor(Color("lightText"))
        }
        .foregroundColor(
            Color("lightText")
        )
        .background(
            routineVM.colors[index % routineVM.colors.count]
                .cornerRadius(15)
                .shadow(radius: 8)
        )
        .frame(
            width: cardWidth,
            height: cardWidth * 1.3
        )
        .zIndex(
            routineVM.currentIndex == index ? 1.0 : -1.0
        )
        .offset(
            x: CGFloat(index - routineVM.currentIndex) * UIScreen.main.bounds.width * 10 / 11
        )
        .scaleEffect(
            routineVM.currentIndex == index ? 1.0 : 0.85
        )
        .onReceive(routineVM.time, perform: { _ in
            
            //do work only after we have begun (when we are no longer showing the snapshot)
            if !routineVM.showSnapshot && !routineVM.paused {
                if index == routineVM.currentIndex {
                    routineVM.updateTime()
                    withAnimation(.linear(duration: 0.1)){
                        timeOnCurrentCard += 1
                    }
                    if progress >= 1 {
                        //mark as complete
                        routineVM.completed[index] = true
                        //then iterate
                        routineVM.next()
                    }
                }
            }
        })
    }
}
struct ExerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCard(index: 0, exercise: Exercise(id: "00", name: "Child's Pose", desc: "", duration_secs: 45, vals: []), routineVM: RoutineViewModel())
    }
}
