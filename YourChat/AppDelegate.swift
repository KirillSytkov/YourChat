//
//  AppDelegate.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {
   var window: UIWindow?
   
   let loginVC = LoginViewController()
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
      FirebaseApp.configure()
      startApp()
   
      return true
   }
   
   @available(iOS 9.0, *)
   func application(_ application: UIApplication, open url: URL,
                    options: [UIApplication.OpenURLOptionsKey: Any])
   -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
   }
   
}

extension AppDelegate {
   func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
      guard animated, let window = self.window else {
         self.window?.rootViewController = vc
         self.window?.makeKeyAndVisible()
         return
      }
      window.rootViewController = vc
      window.makeKeyAndVisible()
      UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
   }
   
   func startApp() {
      if let user = Auth.auth().currentUser {
         
         FirestoreService.shared.getUserData(user: user) { result in
            switch result {
            case .success(let user):
               let mainTabBar = MainTabBarController(currentUser: user)
               mainTabBar.modalPresentationStyle = .fullScreen
               self.setRootViewController(mainTabBar, animated: true)
            case .failure(_):
               self.setRootViewController(AuthViewController(), animated: true)
            }
         }
         
      } else {
         self.setRootViewController(AuthViewController(), animated: true)
      }
   }
}


