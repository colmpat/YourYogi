//
//  RoutineViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 7/13/21.
//

import SwiftUI
import Combine

class RoutineViewModel: ObservableObject {
    @Published var showSnapshot = true
    @Published var currentIndex = 0
    @Published var showButtons = true
    @Published var doneSelection: Int?
    @Published var paused = false
    
    @Published var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var minutes = 0
    @Published var seconds = 0
    
    var exercises = [Exercise]() //exercise and whether or not it was completed
    var completed = [Bool]()
    
    let dateString = Date().formatDate().uppercased()
    let colors = [Color("primary"), Color("pastelBlue"), Color("pastelRed"), Color("lightAccent")]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if let user = UserRepository.shared.user {
            for exercise in user.todaysRoutine.exercises {
                exercises.append(exercise)
                completed.append(false)
            }
        }
    }
    
    func durationString(duration: Int) -> String {
        if duration % 60 == 0 {
            return "\(duration / 60 ) min."
        }
        else {
            if duration < 60 {
                return "\(duration) secs."
            }
            else {
                return "\(duration / 60 ) min. \(duration % 60) secs."
            }
            
        }
    }
    
    func updateTime() {
        if seconds == 59 {
            seconds = 0
            minutes += 1
        }
        else {
            seconds += 1
        }
    }
    
    func next() {
        //if we are on the last index
        if currentIndex == exercises.count - 1 {
            doneSelection = 1
            return
        }
        withAnimation(.spring().speed(0.8)) {
            self.currentIndex += 1
        }
    }
}
