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
   let imageView = UIImageView()
   let nameLabel = UILabel()
   let aboutLabel = UILabel()
   let acceptButton = UIButton(title: "Accept".uppercased(), titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
   let denyButton = UIButton(title: "Deny".uppercased(), titleColor: .systemPink, backgroundColor: .white, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
   
   private var chat: MChat
   weak var delegate: WaitingChatsNavigationDelegate?
   
   init(chat: MChat) {
      self.chat = chat
      nameLabel.text = chat.friendUsername
      imageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL))
      super.init(nibName: nil, bundle: nil)
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
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      self.acceptButton.applyGradients(cornerRadius: 10)
   }
   
   
   //MARK: - Actions
   @objc private func denyButtonTapped(_ sender: UIButton) {
      self.dismiss(animated: true) {
         self.delegate?.removeWaitingChat(chat: self.chat)
      }
   }
   
   @objc private func acceptButtonTapped(_ sender: UIButton) {
      self.dismiss(animated: true) {
         self.delegate?.chatToActive(chat: self.chat)
      }
   }
   
   
   //MARK: - Flow funcs
   private func setup() {
      self.view.backgroundColor = .systemBackground
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.backgroundColor = .systemGray6
      containerView.layer.cornerRadius = 30
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFill
      
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      nameLabel.font = UIFont.systemFont(ofSize: 20,weight: .regular)
      
      aboutLabel.translatesAutoresizingMaskIntoConstraints = false
      aboutLabel.numberOfLines = 1
      aboutLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
      
      acceptButton.translatesAutoresizingMaskIntoConstraints = false
      acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
      
      denyButton.translatesAutoresizingMaskIntoConstraints = false
      denyButton.layer.borderWidth = 1.2
      denyButton.layer.borderColor = UIColor.systemPink.cgColor
      denyButton.addTarget(self, action: #selector(denyButtonTapped(_:)), for: .touchUpInside)
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

