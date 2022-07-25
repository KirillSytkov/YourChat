//
//  UIStackView + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

extension UIStackView {
   convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
      self.init(arrangedSubviews: arrangedSubviews)
      self.axis = axis
      self.spacing = spacing
   }
}
