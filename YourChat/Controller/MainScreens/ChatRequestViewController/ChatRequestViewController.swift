//
//  ChatRequestViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 01.08.2022.
//

import UIKit

class ChatRequestViewController: UIViewController {
   //MARK: - Properties
   let containerView = UIView()
   let imageView = UIImageView(image: "human1.jpg", contentMode: .scaleAspectFill)
   let nameLabel = UILabel(text: "Mark Boner", font: .systemFont(ofSize: 20, weight: .regular))
   let aboutLabel = UILabel(text: "You have the opportunity to start a new chat", font: .systemFont(ofSize: 16, weight: .light))
   let acceptButton = UIButton(title: "Accept".uppercased(), titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
   let denyButton = UIButton(title: "Deny".uppercased(), titleColor: .systemPink, backgroundColor: .white, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      self.acceptButton.applyGradients(cornerRadius: 10)
   }
   
   //MARK: - Flow funcs
   private func setup() {
      self.view.backgroundColor = .systemBackground
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.backgroundColor = .systemGray6
      containerView.layer.cornerRadius = 30
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      
      aboutLabel.translatesAutoresizingMaskIntoConstraints = false
      aboutLabel.numberOfLines = 1
      
      acceptButton.translatesAutoresizingMaskIntoConstraints = false
      
      denyButton.translatesAutoresizingMaskIntoConstraints = false
      denyButton.layer.borderWidth = 1.2
      denyButton.layer.borderColor = UIColor.systemPink.cgColor
   }
   
   private func layout() {
      self.view.addSubview(imageView)
      self.view.addSubview(containerView)
      
      let buttonsStackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 7)
      buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
      buttonsStackView.distribution = .fillEqually
      
      containerView.addSubview(nameLabel)
      containerView.addSubview(aboutLabel)
      containerView.addSubview(buttonsStackView)
      
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
         
         buttonsStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 24),
         buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
         buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
         buttonsStackView.heightAnchor.constraint(equalToConstant: 48),
      ])
   }
   
}


//MARK: - SwiftUI Preview
import SwiftUI

struct CharRequestViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = ChatRequestViewController()
      
      func makeUIViewController(context: Context) -> some ChatRequestViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
