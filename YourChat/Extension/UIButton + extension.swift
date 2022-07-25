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
}
