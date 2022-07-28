//
//  ActiveChatCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 27.07.2022.
//

import UIKit

protocol SelfConfigureCell {
   static var reuseId: String { get }
   func configure(with value: MChat)
}

class ActiveChatCell: UICollectionViewCell {
   
   private let friendImageView = UIImageView()
   private let friendName = UILabel(text: "User name", font: .laoSangamMN20())
   private let lastMessage = UILabel(text: "How are you?",font: .laoSangamMN18())
   private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: .systemPurple, endColor: .systemTeal)
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      layout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

extension ActiveChatCell: SelfConfigureCell {
   
   static var reuseId: String = "ActiveChatCell"
   
   func configure(with value: MChat) {
      friendImageView.image = UIImage(named: value.userImageString)
      friendName.text = value.username
      lastMessage.text = value.lastMessage
   }
   
}

extension ActiveChatCell {
   
   private func setup() {
      self.backgroundColor = .systemBackground
      self.layer.cornerRadius = 5
      self.clipsToBounds = true
      
      friendImageView.translatesAutoresizingMaskIntoConstraints = false
      friendImageView.backgroundColor = .red
      
      friendName.translatesAutoresizingMaskIntoConstraints = false
      
      lastMessage.translatesAutoresizingMaskIntoConstraints = false
      
      gradientView.translatesAutoresizingMaskIntoConstraints = false
   }
   
   private func layout() {
      addSubview(friendImageView)
      addSubview(friendName)
      addSubview(lastMessage)
      addSubview(gradientView)
      
      NSLayoutConstraint.activate([
         friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
         friendImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
         friendImageView.heightAnchor.constraint(equalToConstant: 78),
         friendImageView.widthAnchor.constraint(equalTo: friendImageView.heightAnchor),
         
         friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
         friendName.topAnchor.constraint(equalTo: topAnchor, constant: self.frame.height / 2 - 30),
         
         lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor, constant: 1),
         lastMessage.leadingAnchor.constraint(equalTo: friendName.leadingAnchor),
         lastMessage.trailingAnchor.constraint(equalTo: friendName.trailingAnchor),
         
         gradientView.widthAnchor.constraint(equalToConstant: 5),
         gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
         gradientView.topAnchor.constraint(equalTo: topAnchor),
         gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
         gradientView.leadingAnchor.constraint(equalTo: friendName.trailingAnchor, constant: 16)
         
      ])
   }
}


