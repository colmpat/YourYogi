//
//  YouViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 7/1/21.
//

import Foundation
import Combine
import Firebase

class YouViewModel: ObservableObject {
    @Published var anonymous: Bool = Auth.auth().currentUser?.isAnonymous ?? true
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserRepository.shared.$user
            .map { user in
                return user?.isAnon ?? true
            }
            .assign(to: \.anonymous, on: self)
            .store(in: &cancellables)
    }
}
