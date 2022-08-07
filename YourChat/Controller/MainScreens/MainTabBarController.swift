//
//  MainTabBarController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
   //MARK: - Properties
   
   private let peopleImage = UIImage(systemName: "person.3")
   private let convImage = UIImage(systemName: "bubble.left.and.bubble.right")
   private let currentUser: MUser
   
   init(currentUser: MUser = MUser(username: "Test", email: "Test", avatarStringURL: "test", description: "Test", sex: "male", id: "test")) {
      self.currentUser = currentUser
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupViews()
      setupTabBar()
      
   }
   
   private func setupViews() {
      let listVC = ListViewController(currentUser: currentUser)
      let peopleVC = PeopleViewController(currentUser: currentUser)
      
      viewControllers = [generateNavigationController(rootVC: peopleVC, title: "People", image: peopleImage!),
                         generateNavigationController(rootVC: listVC, title: "Conversations", image: convImage!),
      ]
   }
   
   private func setupTabBar() {
      tabBar.tintColor = .systemPurple
   }
   
   private func generateNavigationController(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
      let navigationVC = UINavigationController(rootViewController: rootVC)
      navigationVC.tabBarItem.title = title
      navigationVC.tabBarItem.image = image
      return navigationVC
   }
}


