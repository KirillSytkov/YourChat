//
//  LoginViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit

class LoginViewController: UIViewController {
   //MARK: - Properties
   private let welcomeLabel = UILabel(text: "Welcome Back!", font: .avenir26())
   
   private let googleLabel = UILabel(text: "Login with")
   private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
   
   private let orLabel = UILabel(text: "or")
   
   private let emailLabel = UILabel(text: "Email")
   private let emailTextFiled = OneLineTextField(font: .avenir20())
   
   private let passwordLabel = UILabel(text: "Password")
   private let passwordTextField = OneLineTextField(font: .avenir20())
   
   private let signUpButton = UIButton(title: "Sing up", titleColor: .white, backgroundColor: .darkGray)
   
   private let alreadyOnboardLabel = UILabel(text: "Need an account?")
   private let loginButton = UIButton()
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   //MARK: - Actions
   @objc private  func loginButtonTapped(_ sender: UIButton) {
      AuthService.shared.login(email: emailTextFiled.text, password: passwordTextField.text) { result in
         switch result {
            
         case .success(let user):
            self.showAlert(with: "Succes", message: "Hello User")
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
   
   //MARK: - Flow func
   private func setup() {
      view.backgroundColor = .systemBackground
      
      welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
      
      googleButton.customizedGoogleButton()
      signUpButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
      
      orLabel.translatesAutoresizingMaskIntoConstraints = false
    
      loginButton.translatesAutoresizingMaskIntoConstraints = false
      loginButton.setTitle("Sign up", for: .normal)
      loginButton.setTitleColor(.systemPink, for: .normal)
      loginButton.titleLabel?.font = .avenir20()
    
      
      passwordTextField.isSecureTextEntry = true
   }
   
   private func layout() {
      let googleView = ButtonFormView(label: googleLabel, button: googleButton)
      
      let emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextFiled], axis: .vertical, spacing: 5)
      let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
      
      let stackView = UIStackView(arrangedSubviews: [googleView, orLabel, emailStackView, passwordStackView, signUpButton], axis: .vertical, spacing: 30)
      
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

struct LoginViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
         
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = LoginViewController()
      
      func makeUIViewController(context: Context) -> some LoginViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}


