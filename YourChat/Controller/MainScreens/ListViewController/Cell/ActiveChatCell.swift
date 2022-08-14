//
//  ActiveChatCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 27.07.2022.
//

import UIKit

class ActiveChatCell: UICollectionViewCell {
   
   //MARK: - Properties
   static var reuseId: String = "ActiveChatCell"
   
   private let friendImageView = UIImageView()
   private let friendName = UILabel()
   private let lastMessage = UILabel()
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

//MARK: - Flow func
extension ActiveChatCell: SelfConfigureCell {
   
   func configure<U>(with value: U) where U : Hashable {
      guard let chat = value as? MChat else { return }
      friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL))
      friendName.text = chat.friendUsername
      lastMessage.text = chat.lastMessageContent
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
      friendName.font = .laoSangamMN20()
      lastMessage.font = .laoSangamMN18()
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


