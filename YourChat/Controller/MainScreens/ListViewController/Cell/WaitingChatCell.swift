//
//  WaitingChatCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 27.07.2022.
//

import Foundation
import UIKit

class WaitingVhatCell: UICollectionViewCell {
   
   private let friendImageView = UIImageView()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      layout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
 
extension WaitingVhatCell: SelfConfigureCell {
   
   func configure<U>(with value: U) where U : Hashable {
      guard let value = value as? MChat else { return }
      friendImageView.image = UIImage(named: value.userImageString)
   }
   
   static var reuseId: String  = "waitingCell"
   
}

extension WaitingVhatCell {
   private func setup(){
      self.layer.cornerRadius = 5
      self.clipsToBounds = true
      
      friendImageView.translatesAutoresizingMaskIntoConstraints = false
   }
   
   private func layout() {
      addSubview(friendImageView)
      
      NSLayoutConstraint.activate([
         friendImageView.topAnchor.constraint(equalTo: topAnchor),
         friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
         friendImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
         friendImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
         
      ])
   }
   
   
}
