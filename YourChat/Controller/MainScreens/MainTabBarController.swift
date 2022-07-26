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
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupViews()
      setupTabBar()
      
   }
   
   private func setupViews() {
      let listVC = ListViewController()
      let peopleVC = PeopleViewController()
      
      viewControllers = [ generateNavigationController(rootVC: listVC, title: "Conversations", image: convImage!),
                          generateNavigationController(rootVC: peopleVC, title: "People", image: peopleImage!)
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


