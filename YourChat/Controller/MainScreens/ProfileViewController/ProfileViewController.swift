//
//  ProfileViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 29.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
   //MARK: - Properties
   let containerView = UIView()
   let imageView = UIImageView(image: "human1.jpg", contentMode: .scaleAspectFill)
   let nameLabel = UILabel(text: "Mark Boner", font: .systemFont(ofSize: 20, weight: .light))
   let aboutLabel = UILabel(text: "Hello my friend", font: .systemFont(ofSize: 16, weight: .light))
   let textField = UITextField()
   
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   
   //MARK: - Flow func
   
   private func setup() {
      self.view.backgroundColor = .systemBackground
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.backgroundColor = .systemGray6
      containerView.layer.cornerRadius = 30
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      
      aboutLabel.translatesAutoresizingMaskIntoConstraints = false
      aboutLabel.numberOfLines = 1
      
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.borderStyle = .roundedRect
      
   }
   
   private func layout() {
      self.view.addSubview(imageView)
      self.view.addSubview(containerView)
      
      containerView.addSubview(nameLabel)
      containerView.addSubview(aboutLabel)
      containerView.addSubview(textField)
      
      NSLayoutConstraint.activate([
         imageView.topAnchor.constraint(equalTo: view.topAnchor),
         imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
         
         containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         containerView.heightAnchor.constraint(equalToConstant: 206),
         
         nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
         nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
         nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
         
         aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
         aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
         aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
         
         textField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
         textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
         textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
         textField.heightAnchor.constraint(equalToConstant: 48),
         
      ])
   }
   
   
}

//MARK: - SwiftUI Preview
import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = ProfileViewController()
      
      func makeUIViewController(context: Context) -> some ProfileViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
