//
//  AppDelegate.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.makeKeyAndVisible()
      window?.backgroundColor = .systemBackground
      window?.rootViewController = AuthViewController()
      FirebaseApp.configure()
      return true
   }

}

