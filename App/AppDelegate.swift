//
//  AppDelegate.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser == nil {
                Auth.auth().signInAnonymously()
                print("Signing in Anonymously...")
            }
            else {
                //if no document for user yet, make it !
                Firestore.firestore().collection("users")
                    .whereField("uid", isEqualTo: auth.currentUser?.uid)
                    .getDocuments { (querySnapshot, error) in
                        if querySnapshot?.documents.first == nil {
                            print("No data for current user, creating documents...")
                            var newUser =
                                User(
                                    firstName: "Anonymous",
                                    lastName: "Yogi",
                                    goals: "",
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
                                    isAnon: user!.isAnonymous
                                )
                            newUser.uid = auth.currentUser?.uid
                            UserRepository.shared.addUser(newUser)
                        }
                        
                    }

            }
            print("Current User ID: \(Auth.auth().currentUser?.uid ?? "none")")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

