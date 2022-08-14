//
//  OneLineTextFiled.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

class OneLineTextField: UITextField {
   
   convenience init(font: UIFont? = .avenir20()) {
      self.init()
      
      self.font = font
      self.borderStyle = .none
      self.translatesAutoresizingMaskIntoConstraints = false
      
      
      var bottonView = UIView()
      bottonView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
      bottonView.backgroundColor = .darkGray
      bottonView.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(bottonView)
      
      NSLayoutConstraint.activate([
         bottonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         bottonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         bottonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         bottonView.heightAnchor.constraint(equalToConstant: 1),
      ])
   }
   
}
