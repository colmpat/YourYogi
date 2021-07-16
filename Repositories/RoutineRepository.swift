//
//  RoutineRepository.swift
//  YourYogi
//
//  Created by Colm Lang on 7/15/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class RoutineRepository: ObservableObject {
    static let shared = RoutineRepository()
    
    private let db = Firestore.firestore()
    
    @Published var routines = [CompletedRoutine]()
    
    init() {
        self.loadRoutines()
    }
    
    func loadRoutines() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("routines")
            .order(by: "dateCompleted")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener{ (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.routines = querySnapshot.documents.compactMap{ document in
                    do {
                        return try document.data(as: CompletedRoutine.self)
                    } catch {
                        print("Error loading Completed Routines: \(error.localizedDescription)")
                    }
                    return nil
                }
            }
            
        }
    }
    
    func addRoutine(_ routine: CompletedRoutine) {
        do {
            var completedRoutine = routine
            completedRoutine.uid = Auth.auth().currentUser?.uid
            
            let _ = try db.collection("routines").addDocument(from: completedRoutine)
        } catch {
            print("Error adding routine: \(error)")
        }
    }
}
