//
//  ListViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit

class ListViewController: UIViewController {
   //MARK: - Properties
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   //MARK: - Actions
   
   
   //MARK: - Flow func
   
}
//MARK: - Extensions


//MARK: - SwiftUI Preview
import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = ListViewController()
      
      func makeUIViewController(context: Context) -> some ListViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}

