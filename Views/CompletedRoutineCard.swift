//
//  CompletedRoutineCard.swift
//  YourYogi
//
//  Created by Colm Lang on 7/29/21.
//

import SwiftUI

struct CompletedRoutineCard: View {
    let routine: CompletedRoutine
    var namespace: Namespace.ID
    @Binding var expanded: Bool
    let date: String
    var body: some View {
        
        ZStack {
            BlurView(style: .systemUltraThinMaterialLight)
                .ignoresSafeArea()
                .animation(.easeInOut)
                .onTapGesture {
                    withAnimation(.spring()) {
                        expanded.toggle()
                    }
                }
            VStack(spacing: 8){
                HStack {
                    Text(date)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .fixedSize()
                        .padding([.top, .horizontal])
                        .matchedGeometryEffect(id: "Title\(routine.hashValue)", in: namespace)
                        
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            expanded.toggle()
                        }
                    }) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color("pastelRed"))
                    }
                    .matchedGeometryEffect(id: "Button\(routine.hashValue)", in: namespace)
                    .padding([.top, .horizontal])
                }
                Divider()
                    .padding(.horizontal)
                if let notes = routine.notes {
                    Text(notes)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding(12)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.5), radius: 15)
                    .matchedGeometryEffect(id: "Background\(routine.hashValue)", in: namespace)
            )
            .padding()
            
        }
    }
}
