//
//  WaitingChatCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 27.07.2022.
//

import Foundation
import UIKit

class WaitingVhatCell: UICollectionViewCell {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
 
extension WaitingVhatCell: SelfConfigureCell {
   static var reuseId: String  = "waitingCell"
   
   func configure(with value: MChat) {
      
   }
   
   
}
