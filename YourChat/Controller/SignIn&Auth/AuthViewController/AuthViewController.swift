//
//  ViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

class AuthViewController: UIViewController {
   //MARK: - Properties
   
   private let logoImageView = UIImageView(image: Constants.Images.logoImage, contentMode: .scaleToFill)
   private let logoLabel = UILabel(text: "YourChat")
 
   private let stackView = UIStackView()
   
   private let googleLabel = UILabel(text: "Get started with")
   private let emailLabel = UILabel(text: "Or sign up with")
   private let alreadyOnboardLabel = UILabel(text: "Already onboard?")
   
   private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
   private let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .darkGray)
   private let loginButton = UIButton(title: "Login", titleColor: .systemPink, backgroundColor: .white,font: UIFont.preferredFont(forTextStyle: .title2), isShadow: true)
   private let signUpVC = SignUpViewController()
   private let loginVC = LoginViewController()
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.signUpVC.delegate = self
      self.loginVC.delegate = self
      
      setup()
      layout()
     
   }
   
   
   //MARK: - Actions
   @objc private func emailButtonTapped(_ sender: UIButton) {
      present(signUpVC, animated: true)
   }
   
   @objc private func loginButtonTapped(_ sender: UIButton) {
      present(loginVC, animated: true)
   }
   
   //MARK: - Flow func
   private func setup() {
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .vertical
      stackView.spacing = 30
      
      logoLabel.translatesAutoresizingMaskIntoConstraints = false
      logoLabel.textAlignment = .center
      logoLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
      logoLabel.textColor = .darkGray
      
      googleButton.customizedGoogleButton()
      
      emailButton.addTarget(self, action: #selector(emailButtonTapped(_:)), for: .touchUpInside)
      
      loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
   }
   
}
//MARK: - Extensions

extension AuthViewController {
   
   private func layout() {
      let googleView = ButtonFormView(label: googleLabel, button: googleButton)
      let emailView = ButtonFormView(label: emailLabel, button: emailButton)
      let alreadyOnboardingView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
      
      view.addSubview(logoImageView)
      view.addSubview(logoLabel)
      stackView.addArrangedSubview(googleView)
      stackView.addArrangedSubview(emailView)
      stackView.addArrangedSubview(alreadyOnboardingView)
      view.addSubview(stackView)
      
      NSLayoutConstraint.activate([
         logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
         logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         logoImageView.heightAnchor.constraint(equalToConstant: 100),
         logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
         
         logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
         logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
         stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 100),
         stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
         
      ])
   }
}

extension AuthViewController: AuthNaigationDelegate {
   func toLoginVC() {
      present(loginVC, animated: true)
   }
   
   func toSignUp() {
      present(signUpVC, animated: true)
   }
     
}

//MARK: - SwiftUI Preview
import SwiftUI

struct AuthViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
         
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = AuthViewController()
      
      func makeUIViewController(context: Context) -> some AuthViewController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
