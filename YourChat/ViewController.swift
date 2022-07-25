//
//  ViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      
   }


}

import SwiftUI

struct ViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
         
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = ViewController()
      
      func makeUIViewController(context: Context) -> some ViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
