//
//  UILabale + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 25.07.2022.
//

import UIKit

extension UILabel {
   convenience init(text: String, font: UIFont? = .avenir20()) {
      self.init()
      self.font = font
      self.text = text
   }
}
