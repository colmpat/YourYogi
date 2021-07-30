//
//  CompletedRoutineCell.swift
//  YourYogi
//
//  Created by Colm Lang on 7/22/21.
//

import SwiftUI

struct CompletedRoutineCell: View {
    let routine: CompletedRoutine
    var namespace: Namespace.ID
    
    var body: some View {
        HStack {
            Text("This routine")
                .fixedSize()
                .padding()
                .matchedGeometryEffect(id: "Title\(routine.hashValue)", in: namespace)
            Spacer()
            Image(systemName: "chevron.right")
                .matchedGeometryEffect(id: "Button\(routine.hashValue)", in: namespace)
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 15)
                .matchedGeometryEffect(id: "Background\(routine.hashValue)", in: namespace)
        )
    }
}
