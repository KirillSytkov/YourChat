//
//  UIScrollView + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 14.08.2022.
//

import UIKit

extension UIScrollView {
   var isAtBottom: Bool {
      return contentOffset.y >= verticalOffsetForBottom
   }
   
   var verticalOffsetForBottom: CGFloat {
      let scrollViewHeight = bounds.height
      let scrollContentSizeHeight = contentSize.height
      let bottomInset = contentInset.bottom
      let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
      return scrollViewBottomOffset
   }
}
