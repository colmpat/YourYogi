//
//  TodayViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import Combine

class TodayViewModel: ObservableObject {
    @Published var scroll = false
    @Published var showFocuses = false
    
    @Published var user = UserRepository.shared.user
    @Published var userHasFocuses = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        //Subscribing to user for changes in focuses date generated
        UserRepository.shared.$user
            .map({ user in
                if let date = user?.todaysFocuses.dateGenerated?.dateValue() {
                    return Calendar.current.isDateInToday(date)
                } else {
                    return false
                }
            })
            .assign(to: \.userHasFocuses, on: self)
            .store(in: &cancellables)
        
        //Let self.user subscribe to User from UserRepository
        UserRepository.shared.$user
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
        
    }
}
