//
//  InsertableTextField.swift
//  YourChat
//
//  Created by Kirill Sytkov on 29.07.2022.
//

import UIKit

class InsertableTextField: UITextField {
   //MARK: - Properties
   let imageView = UIImageView(image: UIImage(systemName: "smiley"))
   let button = UIButton(type: .system)
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension InsertableTextField {
   private func setup() {
      backgroundColor = .white
      placeholder = " White something here ..."
      font = UIFont.systemFont(ofSize: 14)
      clearButtonMode = .whileEditing
      borderStyle = .none
      layer.cornerRadius = 18
      layer.masksToBounds = true
      
      imageView.tintColor = .systemGray2
      leftView = imageView
      leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
      leftViewMode = .always
      
      button.setImage(UIImage(named: "Sent"), for: .normal)

      rightView = button
      rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
      rightViewMode = .always
      
   }
   
}

extension InsertableTextField {
   override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
      var rect = super.leftViewRect(forBounds: bounds)
      rect.origin.x += 12
      return rect
   }
   
   override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
      var rect = super.rightViewRect(forBounds: bounds)
      rect.origin.x -= 12
      return rect
   }
   
   override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 40, dy: 0)
   }
   
   override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 40, dy: 0)
   }
   
   override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 40, dy: 0)
   }
}
