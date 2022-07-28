//
//  UserCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import UIKit

class UserCell: UICollectionViewCell  {
   
   let userImageView = UIImageView()
   let userName = UILabel(text: "Name", font: .laoSangamMN20())
   let containerView = UIView()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      layout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   override func layoutSubviews() {
      super.layoutSubviews()
      self.containerView.layer.cornerRadius = 4
      self.containerView.clipsToBounds = true
   }
   
}

extension UserCell: SelfConfigureCell {
   func configure<U>(with value: U) where U : Hashable {
      guard let value = value as? MUser else { return }
      userImageView.image = UIImage(named: value.avatarStringURL )
      userName.text = value.username
   }
   
   static var reuseId: String {
      "UserCell"
   }
   
}

extension UserCell {
   private func setup() {
      self.dropShadow()
      self.backgroundColor = .systemGray6
      self.layer.cornerRadius = 4
      
      userImageView.translatesAutoresizingMaskIntoConstraints = false
      
      userName.translatesAutoresizingMaskIntoConstraints = false
      userName.numberOfLines = 1
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.layer.cornerRadius = 5
      containerView.backgroundColor = .white
   }
   
   private func layout() {
      addSubview(containerView)
      containerView.addSubview(userImageView)
      containerView.addSubview(userName)
      
      NSLayoutConstraint.activate([
         containerView.topAnchor.constraint(equalTo: topAnchor),
         containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
         containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
         containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
         
         
         userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
         userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         userImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
         
         userName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
         userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         userName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
         userName.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
      ])
   }
   
}
