//
//  History.swift
//  YourYogi
//
//  Created by Colm Lang on 7/4/21.
//

import SwiftUI

struct History: View {
    var body: some View {
        ZStack {
            Color("lightNeutral")
                .ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("2021")
                        .bold()
                        .font(.largeTitle)
                        .padding([.bottom, .leading])
                    Text("June")
                        .bold()
                        .font(.title)
                        .padding([.bottom, .leading])
                    Text("Jun 25")
                        .bold()
                        .font(.callout)
                        .padding([.bottom, .leading])
                }
                
            }
        }
        
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
