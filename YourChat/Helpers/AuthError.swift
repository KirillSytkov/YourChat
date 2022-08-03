 //
//  AuthError.swift
//  YourChat
//
//  Created by Kirill Sytkov on 02.08.2022.
//

import Foundation

enum AuthError {
   case notFilled
   case invalidEmail
   case passwordNotMatched
   case unknownError
   case serverError
}

extension AuthError: LocalizedError {
   var errorDescription: String? {
      switch self {
         
      case .notFilled:
         return NSLocalizedString("Placeholder all fields", comment: "")
      case .invalidEmail:
         return NSLocalizedString("Incorrect mail format", comment: "")
      case .passwordNotMatched:
         return NSLocalizedString("Passwords do not match", comment: "")
      case .unknownError:
         return NSLocalizedString("Unknown error", comment: "")
      case .serverError:
         return NSLocalizedString("Server error", comment: "")
      }
   }
   
}
