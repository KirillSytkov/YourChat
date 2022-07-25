//
//  UIView + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//


import UIKit

extension UIView {
   
    func dropShadow(color: CGColor = UIColor.black.cgColor, opacity: Float = 0.5, radius: CGFloat = 10, offset: CGSize = CGSize(width: 10, height: 10)) {
      self.layer.masksToBounds = false
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 0.5
      self.layer.shadowRadius = 10
      self.layer.shadowOffset = CGSize(width: 10, height: 10)
      self.layer.shouldRasterize = true
      self.layer.rasterizationScale = UIScreen.main.scale
   }
}

