//
//  FocusesViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 6/24/21.
//

import Foundation
import Combine

class FocusesViewModel: ObservableObject {
    
    let dateString = Date().formatDate().uppercased()
    
    @Published var newFocuses = [Focus]()
    @Published var duration: Duration = .ten
    
    @Published var newFocusesNil = true
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.$newFocuses
            .map({ focuses in
                return focuses.count == 0
            })
            .assign(to: \.newFocusesNil, on: self)
            .store(in: &cancellables)
    }
    func setFocuses() {
        UserRepository.shared.setTodaysFocuses(self.newFocuses, duration: self.duration)
        if let routine = YogiBrain.shared.generateRoutine() {
            UserRepository.shared.setTodaysRoutine(routine)
        }
    }
    func move(indexSet: IndexSet, destination: Int) {
        self.newFocuses.move(fromOffsets: indexSet, toOffset: destination)
    }
    func delete(indexSet: IndexSet) {
        if let index = indexSet.first {
            newFocuses.remove(at: index)
        }
        
    }
}
