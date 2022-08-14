//
//  UIButton + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//


import UIKit

extension UIButton {
   
   convenience init(title: String,
                    titleColor: UIColor,
                    backgroundColor: UIColor,
                    font:UIFont? = .avenir20(),
                    isShadow:Bool = false,
                    cornerRadius: CGFloat = 5){
      self.init(type:.system)
      self.setTitle(title, for: .normal)
      self.setTitleColor(titleColor, for: .normal)
      self.backgroundColor = backgroundColor
      self.titleLabel?.font = font
      self.layer.cornerRadius = cornerRadius
      
      if isShadow {
         self.dropShadow()
      }
   }
   
   func customizedGoogleButton() {
      let googleLogo = UIImageView(image: "googleIcon.png", contentMode: .scaleAspectFit)
      googleLogo.translatesAutoresizingMaskIntoConstraints = false
      
      self.addSubview(googleLogo)
      
      NSLayoutConstraint.activate([
         googleLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
         googleLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         googleLogo.heightAnchor.constraint(equalToConstant: 20),
         googleLogo.widthAnchor.constraint(equalTo: googleLogo.heightAnchor),
         
      ])
   }
   
}
