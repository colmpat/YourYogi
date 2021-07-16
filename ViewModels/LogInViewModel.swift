//
//  LogInViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class LogInViewModel:  ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var showPassword = false
    @Published var login = true
    @Published var validEmail = true
    @Published var validPassword = true
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var goals = ""
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    private var onSignedIn: (() -> Void)?
    
    func logInWithEmailPassword(onSignedIn: @escaping () -> Void) {
        self.onSignedIn = onSignedIn
        //guard to ensure all fields are filled
        guard self.email != "" && self.password != "" else {return}
        self.auth.signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("success, \(self.auth.currentUser?.email ?? "") signed in")
                if let callback = self.onSignedIn {
                    callback()
                }
            }
        }
    }
    func signUpWithEmailPassword(onSignedIn: @escaping () -> Void) {
        self.onSignedIn = onSignedIn
        //guard to ensure all fields are filled
        guard self.email != "" && self.password != "" else {return}
        
        if auth.currentUser != nil {
            let credential = EmailAuthProvider.credential(withEmail: self.email, password: self.password)
            
            auth.currentUser?.link(with: credential, completion: { (result, error) in
                if let error = error {
                    if (error as NSError).code == AuthErrorCode.credentialAlreadyInUse.rawValue {
                        print("The user you are trying to sign in with has already been linked.")
                    } else {
                        print("Error signing in: \(error.localizedDescription)")
                    }
                }
                else {
                    
                    print("user signed up successfully")
                    var newUser =
                        User(
                            firstName: self.firstName,
                            lastName: self.lastName,
                            goals: self.goals,
                            todaysRoutine:
                                Routine(
                                    exercises: [],
                                    dateGenerated: Timestamp(date: Date(timeIntervalSince1970: 0))
                                ),
                            todaysFocuses:
                                Focuses(
                                    focuses: [],
                                    dateGenerated: Timestamp(date: Date(timeIntervalSince1970: 0))
                                ),
                            isAnon: false
                        )
                    newUser.uid = self.auth.currentUser?.uid
                    
                    //add a new document in collection "users"
                    UserRepository.shared.addUser(newUser)
                    if let callback = self.onSignedIn {
                        callback()
                    }
                }
            })
        }
        else {
            auth.createUser(withEmail: self.email, password: self.password) { (authResult, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("user signed up successfully")
                    var newUser =
                        User(
                            firstName: self.firstName,
                            lastName: self.lastName,
                            goals: self.goals,
                            todaysRoutine:
                                Routine(
                                    exercises: [],
                                    dateGenerated: Timestamp(date: Date(timeIntervalSince1970: 0))
                                ),
                            todaysFocuses:
                                Focuses(
                                    focuses: [],
                                    dateGenerated: Timestamp(date: Date(timeIntervalSince1970: 0))
                                ),
                            isAnon: false
                        )
                    newUser.uid = self.auth.currentUser?.uid
                    
                    //add a new document in collection "users"
                    UserRepository.shared.addUser(newUser)
                    if let callback = self.onSignedIn {
                        callback()
                    }
                }
            }
        }
        
    }
    func fieldsNotFilled() -> Bool {
        return self.firstName == "" || self.lastName == "" || self.goals == "" || self.email == "" || self.password == ""
    }
    func clearFields() {
        self.email = ""
        self.password = ""
        if self.login {
            self.firstName = ""
            self.lastName = ""
            self.goals = ""
        }
    }
}
