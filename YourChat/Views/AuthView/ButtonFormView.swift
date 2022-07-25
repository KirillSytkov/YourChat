//
//  ButtonFormView.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

class ButtonFormView: UIView {
   
   init(label: UILabel, button: UIButton) {
      super.init(frame: .zero)
      
      self.translatesAutoresizingMaskIntoConstraints = false
      label.translatesAutoresizingMaskIntoConstraints = false
      button.translatesAutoresizingMaskIntoConstraints = false
      
      self.addSubview(label)
      self.addSubview(button)

      NSLayoutConstraint.activate([
         label.topAnchor.constraint(equalTo: self.topAnchor),
         label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         
         button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
         button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         button.heightAnchor.constraint(equalToConstant: 60),
         button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      ])
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
  
}
