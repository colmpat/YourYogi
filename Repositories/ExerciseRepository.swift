//
//  ExerciseRepository.swift
//  YourYogi
//
//  Created by Colm Lang on 6/24/21.
//

import Foundation
import Combine


class ExerciseRepository: ObservableObject {
    
    static let shared = ExerciseRepository()
    
    @Published var exercises = [Exercise]()
    
    init() {
        self.loadExercises()
    }
    
    func loadExercises() {
        guard let url = Bundle.main.url(forResource: "ExerciseData", withExtension: "JSON") else { return }
        do {
            let data = try Data(contentsOf: url)
            self.exercises = try JSONDecoder().decode([Exercise].self, from: data)
        } catch {
            print("Error fetching exercises: \(error.localizedDescription)")
        }
    }
   
}
