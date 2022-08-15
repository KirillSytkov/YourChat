 //
//  SetupProfileViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
   
   //MARK: - Properties
   private let welcomeLabel = UILabel(text: "Set up profile", font: .avenir26())
   
   private let fullImageView = AddPhotoView()
   
   private let fullNameLabel = UILabel(text: "Full name")
   private let fullNameTextField = OneLineTextField(font: .avenir20())
   
   private let aboutLabel = UILabel(text: "About me")
   private let aboutTextField = OneLineTextField(font: .avenir20())
   
   private let sexLabel = UILabel(text: "Sex")
   private let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
   
   private let signUpButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .darkGray)
   
   private let currentUser: User
   
   init(currentUser: User) {
      self.currentUser = currentUser
      super.init(nibName: nil, bundle: nil)
      
      if let username = currentUser.displayName {
         fullNameTextField.text = username
      }
      
      if let photoURL = currentUser.photoURL {
         fullImageView.circleImageView.sd_setImage(with: photoURL)
      }
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      layout()
   }
   
   
   //MARK: - Actions
   @objc private func signUpButtonTapped(_ sender: UIButton) {
      
      FirestoreService.shared.saveProfileWith(id: currentUser.uid, email: currentUser.email!, username: fullNameTextField.text, avatarImage: fullImageView.circleImageView.image, description: aboutTextField.text, sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
         
         switch result{
         case .success(let user):
            self.showAlert(with: "Success", message: "Profile data saved") {
               let mainTabBar = MainTabBarController(currentUser: user)
               mainTabBar.modalPresentationStyle = .fullScreen
               self.present(mainTabBar, animated: true)
            }
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
   
   @objc private func plusButtonTapped(_ sender: UIButton) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.sourceType = .photoLibrary
      present(imagePickerController, animated: true)
   }
   
   
   //MARK: - Flow funcs
   private func setup() {
      self.view.backgroundColor = .systemBackground
      
      fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
      
      welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
      sexLabel.translatesAutoresizingMaskIntoConstraints = false
      sexSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
      
      signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
   }
   
   private func layout() {
      let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel,fullNameTextField], axis: .vertical, spacing: 5)
      let aboutStackView = UIStackView(arrangedSubviews: [aboutLabel, aboutTextField], axis: .vertical, spacing: 5)
      let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl],axis: .vertical,spacing: 5)
      
      let stackView = UIStackView(arrangedSubviews: [ fullNameStackView, aboutStackView,sexStackView, signUpButton], axis: .vertical, spacing: 30)
      
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(welcomeLabel)
      view.addSubview(fullImageView)
      view.addSubview(stackView)
      
      
      NSLayoutConstraint.activate([
         welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
         welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
         fullImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
         fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
         stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
         
         signUpButton.heightAnchor.constraint(equalToConstant: 60),
      ])
   }
   
}


//MARK: - Extensions
extension SetupProfileViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      picker.dismiss(animated: true)
      guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
      fullImageView.circleImageView.image = image
   }
}



