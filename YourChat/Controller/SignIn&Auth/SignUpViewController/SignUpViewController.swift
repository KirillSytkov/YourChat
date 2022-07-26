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
   
   weak var delegate: AuthNaigationDelegate?
   
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   
   //MARK: - Actions
   @objc private func signupButtonTapepd(_ sender: UIButton) {
      AuthService.shared.register(email: emailTextFiled.text, password: passwordTextField.text, confirmPassword: confirmTextField.text) { result in
         switch result {
         case .success(let user):
            self.showAlert(with: "Success", message: "You are registered") {
               self.present(SetupProfileViewController(currentUser: user), animated: true)
            }
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
   
   @objc private func loginButtonTapped(_ sender: UIButton) {
      dismiss(animated: true) {
         self.delegate?.toLoginVC()
      }
   }
   
   
   //MARK: - flow func
   private func setup() {
      view.backgroundColor = .systemBackground
      
      welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
      
      signUpButton.addTarget(self, action: #selector(signupButtonTapepd(_:)), for: .touchUpInside)
      
      passwordTextField.isSecureTextEntry = true
      confirmTextField.isSecureTextEntry = true
      
      loginButton.translatesAutoresizingMaskIntoConstraints = false
      loginButton.setTitle("Login", for: .normal)
      loginButton.setTitleColor(.systemPink, for: .normal)
      loginButton.titleLabel?.font = .avenir20()
      loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
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
