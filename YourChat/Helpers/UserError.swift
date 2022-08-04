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
   case cannotUnwrapToMUser
   case cannotGetUserInfo
   
}

extension UserError: LocalizedError {
   var errorDescription: String? {
      switch self {
         
      case .notFilled:
         return NSLocalizedString("Placeholder all fields", comment: "")
      case .photoNotExist:
         return NSLocalizedString("Choose avatar please", comment: "")
      case .cannotGetUserInfo:
         return NSLocalizedString("Cannot get information about this user", comment: "")
      case .cannotUnwrapToMUser:
         return NSLocalizedString("Cannot unwrap MUser to User", comment: "")
      }
   }
   
}

