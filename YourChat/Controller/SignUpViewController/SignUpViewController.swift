//
//  SignUpViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
   //MARK: - Properties
   private let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
   

   private let emailLabel = UILabel(text: "Email")
   private let emailTextFiled = OneLineTextField(font: .avenir20())
   
   private let passwordLabel = UILabel(text: "Password")
   private let passwordTextField = OneLineTextField(font: .avenir20())
   
   private let confirmLabel = UILabel(text: "Confirm password")
   private let confirmTextField = OneLineTextField(font: .avenir20())
   
   private let signUpButton = UIButton(title: "Sing up", titleColor: .white, backgroundColor: .darkGray)
   
   private let alreadyOnboardLabel = UILabel(text: "Already onboard?")
   private let loginButton = UIButton()
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   //MARK: - Actions
   
   
   //MARK: - flow func
   private func setup() {
      welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
      
      loginButton.translatesAutoresizingMaskIntoConstraints = false
      loginButton.setTitle("Login", for: .normal)
      loginButton.setTitleColor(.systemPink, for: .normal)
      loginButton.titleLabel?.font = .avenir20()
      
      passwordTextField.isSecureTextEntry = true
      confirmTextField.isSecureTextEntry = true
   }
   
   private func layout() {
      let emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextFiled], axis: .vertical, spacing: 5)
      let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
      let confirmStackView = UIStackView(arrangedSubviews: [confirmLabel, confirmTextField], axis: .vertical, spacing: 5)
      
      let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, confirmStackView, signUpButton], axis: .vertical, spacing: 30)
      
      let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel,loginButton], axis: .horizontal, spacing: 20)
      
      stackView.translatesAutoresizingMaskIntoConstraints = false
      bottomStackView.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(welcomeLabel)
      view.addSubview(stackView)
      view.addSubview(bottomStackView)

      NSLayoutConstraint.activate([
         welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
         welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
         
         signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
         bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
         bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      ])
      
   }
   
}
//MARK: - Extensions

//MARK: - SwiftUI Preview
import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
         
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = SignUpViewController()
      
      func makeUIViewController(context: Context) -> some SignUpViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
