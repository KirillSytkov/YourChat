//
//  LoginViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit
import GoogleSignIn

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
   
   private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .darkGray)
   
   private let alreadyOnboardLabel = UILabel(text: "Need an account?")
   private let signUpButton = UIButton()
   
   weak var delegate: AuthNaigationDelegate?
   
   
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
            self.showAlert(with: "Success", message: "Hello User") {
               FirestoreService.shared.getUserData(user: user) { result in
                  switch result {
                  case .success(let muser):
                     let mainTabBar = MainTabBarController(currentUser: muser)
                     let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                     window?.rootViewController = mainTabBar
                     UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
                  case .failure(_):
                     self.present(SetupProfileViewController(currentUser:user), animated: true)
                  }
               }
            }
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
   
   @objc private  func signUpButtonTapped(_ sender: UIButton) {
      dismiss(animated: true) {
         self.delegate?.toSignUp()
      }
   }
   
   @objc private func googleButtonTapped(_ sender: UIButton) {
      AuthService.shared.googleLogin(view: self) { result in
         switch result {
         case .success(let user):
            FirestoreService.shared.getUserData(user: user) { result in
               switch result {
               case .success(let muser):
                  self.showAlert(with: "Success", message: "You are registred") {
                     let mainTabBar = MainTabBarController(currentUser: muser)
                     let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                     window?.rootViewController = mainTabBar
                     UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
                  }
               case .failure(_):
                  self.showAlert(with: "Success", message: "You are registred") {
                     self.present(SetupProfileViewController(currentUser: user), animated: true)
                  }
               }
            }
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
      googleButton.addTarget(self, action: #selector(googleButtonTapped(_:)), for: .touchUpInside)
      
      loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
      
      orLabel.translatesAutoresizingMaskIntoConstraints = false
    
      signUpButton.translatesAutoresizingMaskIntoConstraints = false
      signUpButton.setTitle("Sign up", for: .normal)
      signUpButton.setTitleColor(.systemPink, for: .normal)
      signUpButton.titleLabel?.font = .avenir20()
      signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
      
      passwordTextField.isSecureTextEntry = true
   }
   
   private func layout() {
      let googleView = ButtonFormView(label: googleLabel, button: googleButton)
      
      let emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextFiled], axis: .vertical, spacing: 5)
      let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
      
      let stackView = UIStackView(arrangedSubviews: [googleView, orLabel, emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 30)
      
      let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel,signUpButton], axis: .horizontal, spacing: 20)
      
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
         
         loginButton.heightAnchor.constraint(equalToConstant: 60),
            
         bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
         bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      ])
   }
}

