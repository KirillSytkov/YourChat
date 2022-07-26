//
//  AddPhotoView.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit

class AddPhotoView: UIView {
   
   var circleImageView: UIImageView = {
      let image = UIImageView()
      image.translatesAutoresizingMaskIntoConstraints = false
      image.image = UIImage(named: "avatar.png")
      image.contentMode = .scaleAspectFill
      image.clipsToBounds = true
      image.layer.borderColor = UIColor.black.cgColor
      image.layer.borderWidth = 1
      return image
   }()
   
   let plusButton: UIButton = {
      let button = UIButton(type: .system)
      button.translatesAutoresizingMaskIntoConstraints = false
      let image = UIImage(named: "plus.png")
      button.setImage(image, for: .normal)
      button.tintColor = .systemPink
      return button
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      style()
      layout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
      super.layoutSubviews()
      circleImageView.layer.masksToBounds = true
      circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
      
      plusButton.layer.masksToBounds = true
      plusButton.layer.cornerRadius = plusButton.frame.width / 2
   }
}

extension AddPhotoView {
   func style() {
      translatesAutoresizingMaskIntoConstraints = false
   }
   
   func layout() {
      addSubview(circleImageView)
      addSubview(plusButton)
      
      NSLayoutConstraint.activate([
         circleImageView.topAnchor.constraint(equalTo: topAnchor),
         circleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
         circleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
         circleImageView.heightAnchor.constraint(equalToConstant: 100),
         circleImageView.widthAnchor.constraint(equalTo: circleImageView.heightAnchor),
         
         plusButton.widthAnchor.constraint(equalToConstant:30),
         plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor),
         plusButton.trailingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: -10),
         plusButton.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 5),
         
         bottomAnchor.constraint(equalTo: plusButton.bottomAnchor),
             
      ])
   }
}

