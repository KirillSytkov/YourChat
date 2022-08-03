//
//  AuthService.swift
//  YourChat
//
//  Created by Kirill Sytkov on 01.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class AuthService {
   
   static let shared = AuthService()
   private let auth = Auth.auth()
   
   func register(email: String? , password: String?, confirmPassword: String?, completion: @escaping (Result<User,Error>) -> Void) {
      guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword)  else {
         completion(.failure(AuthError.notFilled))
         return
      }
      
      guard password!.lowercased() == confirmPassword!.lowercased() else {
         completion(.failure(AuthError.passwordNotMatched))
         return
      }
      
      guard Validators.isSimpleEmail(email!) else {
         completion(.failure(AuthError.invalidEmail))
         return
      }
      
      auth.createUser(withEmail: email!, password: password!) { result, error in
         guard let result = result else {
            completion(.failure(error!))
            return
         }
         completion(.success(result.user))
      }
   }
   
   func login(email: String?, password: String?, completion: @escaping (Result<User,Error>) -> Void) {
      guard let email = email, let password = password else {
         completion(.failure(AuthError.notFilled))
         return
      }

      auth.signIn(withEmail: email, password: password) { result, error in
         guard let result = result else {
            completion(.failure(error!))
            return
         }
         completion(.success(result.user))
      }
   }
   
}

