//
//  UserRepository.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
    static let shared = UserRepository()
    private let db = Firestore.firestore()
    
    @Published var user: User?
    
    init() {
        self.loadUser()
    }
    
    func loadUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener{ (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                do {
                    self.user = try querySnapshot.documents.first?.data(as: User.self)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func addUser(_ user: User) {
        do {
            var addedUser = user
            addedUser.uid = Auth.auth().currentUser?.uid
            let _ = try db.collection("users").addDocument(from: addedUser)
            self.loadUser()
        } catch {
            fatalError("Unable to encode user: \(error.localizedDescription)")
        }
    }
    
    func setTodaysRoutine(_ routine: [Exercise]) {
        user?.todaysRoutine = Routine(exercises: routine)
        self.updateUser()
    }
    
    func setTodaysFocuses(_ focuses: [Focus], duration: Duration) {
        user?.todaysFocuses = Focuses(focuses: focuses, duration: duration)
        self.updateUser()
    }
    
    private func updateUser() {
        if let userId = user?.id {
            do {
                try db.collection("users").document(userId).setData(from: self.user)
            } catch {
                print("Error setting today's routine: \(error.localizedDescription)")
            }
        }
    }
}
