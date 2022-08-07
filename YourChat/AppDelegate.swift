//
//  AppDelegate.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
      FirebaseApp.configure()
      
      if let user = Auth.auth().currentUser {
         
         FirestoreService.shared.getUserData(user: user) { result in
            
            switch result {
            case .success(let user):
               let mainTabBar = MainTabBarController(currentUser: user)
               mainTabBar.modalPresentationStyle = .fullScreen
               
               self.window?.makeKeyAndVisible()
               self.window?.rootViewController = mainTabBar
               
            case .failure(let error):
               self.window?.makeKeyAndVisible()
               self.window?.rootViewController = AuthViewController()
               
            }
         }
         
      } else {
         self.window?.makeKeyAndVisible()
         self.window?.rootViewController = AuthViewController()
         
      }
  
  
      return true
   }
   
}

