//
//  YogiBrain.swift
//  YourYogi
//
//  Created by Colm Lang on 6/24/21.
//

import Foundation
import Combine

class YogiBrain: ObservableObject {
    
    static var shared = YogiBrain()
    
    var todaysFocuses: Focuses?
    private var cancellables = Set<AnyCancellable>()
    
    private var exercises = [Exercise]()
    
    init() {
        
        UserRepository.shared.$user
            .map({ user in
                return user?.todaysFocuses
            })
            .assign(to: \.todaysFocuses, on: self)
            .store(in: &cancellables)
        
        self.exercises = ExerciseRepository.shared.exercises
    }
    
    func generateRoutine() -> [Exercise]? {
        
        guard let focuses = self.todaysFocuses else {return nil}
        
        print("YourYogi generating routine...\nPrimary focus: \(focuses.focuses.first?.rawValue ?? "none")\nDuration: \(focuses.duration.rawValue / 60) min.")
        
        var routine = [Exercise]()
        
        
        var index = 0
        var totalTime = 0
        while index < self.exercises.count && totalTime < focuses.duration.rawValue {
            let newExercise = self.exercises[index]
            routine.append(newExercise)
            totalTime += newExercise.duration_secs
            index += 1
        }
        
        print("Routine generated...\nRoutine Duration: \(totalTime / 60) min\(totalTime % 60 == 0 ? "" : " \(totalTime % 60) sec").")
        return routine.shuffled()
    }
}
