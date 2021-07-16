//
//  RoutineProgress.swift
//  YourYogi
//
//  Created by Colm Lang on 7/14/21.
//

import SwiftUI

struct RoutineProgress: View {
    @ObservedObject var routineVM: RoutineViewModel
    
    var body: some View {
        HStack(spacing: 5){
            ForEach(routineVM.exercises.indices) { index in
                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        index > routineVM.currentIndex ?
                            Color.gray
                            .opacity(0.4):
                            Color("darkNeutral")
                            .opacity(routineVM.showButtons ? 1 : 0.5)
                    )
                    .frame(height: 5)
            }
            
        }
        .padding(.horizontal, 10)
    }
}

struct RoutineProgress_Previews: PreviewProvider {
    static var previews: some View {
        RoutineProgress(routineVM: RoutineViewModel())
    }
}
