//
//  UserError.swift
//  YourChat
//
//  Created by Kirill Sytkov on 03.08.2022.
//

import Foundation

enum UserError {
   case notFilled
   case photoNotExist
}

extension UserError: LocalizedError {
   var errorDescription: String? {
      switch self {
         
      case .notFilled:
         return NSLocalizedString("Placeholder all fields", comment: "")
      case .photoNotExist:
         return NSLocalizedString("Choose avatar please", comment: "")
      }
   }
   
}

