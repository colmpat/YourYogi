//
//  HomeViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var userRepository = UserRepository.shared
    @Published var user: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentTab: Tab = .today
    @Published var splashOffset: CGSize = .zero
    @Published var showSplash: Bool = false
    @Published var showMenu = false
    @Published var today = Date().formatDate()
    @Published var home = true
    
    init() {
        userRepository.$user
        .assign(to: \.user, on: self)
        .store(in: &cancellables)
    }
    
    func toggleMenu() {
        withAnimation(.spring(response: self.showMenu ? 0.45 : 0.6)){
            self.showMenu.toggle()
        }
    }
    func pressTab(tab: Tab) {
        self.currentTab = tab
        self.toggleMenu()
    }
}

enum Tab : String, CaseIterable {
    case today, focuses, settings, you
}

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return dateFormatter.string(from: self)
    }
}
