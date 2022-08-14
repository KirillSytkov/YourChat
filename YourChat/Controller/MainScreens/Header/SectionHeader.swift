//
//  SectionHeader.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
   
   //MARK: - Properties
   static let reuseId = "SectionHeader"
   
   let title = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      layout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


//MARK: - Setup funcs
extension SectionHeader {
   
   private func setup() {
      title.translatesAutoresizingMaskIntoConstraints = false
   }
   
   private func layout() {
      addSubview(title)
      
      NSLayoutConstraint.activate([
         title.topAnchor.constraint(equalTo: topAnchor),
         title.leadingAnchor.constraint(equalTo: leadingAnchor),
         title.trailingAnchor.constraint(equalTo: trailingAnchor),
         title.bottomAnchor.constraint(equalTo: bottomAnchor),
      ])
   }
   
   
   func configure(text: String, font: UIFont?, textColor: UIColor) {
      title.text = text
      title.textColor = textColor
      title.font = font
   }
}
