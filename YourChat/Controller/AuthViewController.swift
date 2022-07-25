//
//  ViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

class AuthViewController: UIViewController {
   //MARK: - Properties
   
   let logoImageView = UIImageView(image: Constants.Images.logoImage, contentMode: .scaleToFill)
   let logoLabel = UILabel(text: "YourChat")
 
   let stackView = UIStackView()
   
   let googleLabel = UILabel(text: "Get started with")
   let emailLabel = UILabel(text: "Or sign up with")
   let alreadyOnboardLabel = UILabel(text: "Already onboard?")
   
   let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
   let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .darkGray)
   let loginButton = UIButton(title: "Login", titleColor: .systemPink, backgroundColor: .white,font: UIFont.preferredFont(forTextStyle: .title2), isShadow: true)
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   
   //MARK: - Actions
   
   
   //MARK: - Flow func
   private func setup() {
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .vertical
      stackView.spacing = 30
      
      logoLabel.translatesAutoresizingMaskIntoConstraints = false
      logoLabel.textAlignment = .center
      logoLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
      logoLabel.textColor = .darkGray
      
      
   }
   
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
//MARK: - Extensions


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
