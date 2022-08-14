//
//  UIImageView + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

extension UIImageView {
   convenience init(image:	String, contentMode: UIView.ContentMode) {
      self.init()
      self.translatesAutoresizingMaskIntoConstraints = false
      self.image = UIImage(named: image)
      self.contentMode = contentMode
   }
}
