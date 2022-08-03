//
//  FirestoreService.swift
//  YourChat
//
//  Created by Kirill Sytkov on 03.08.2022.
//

import FirebaseCore
import FirebaseFirestore

class FirestoreService {
   
   static let shared = FirestoreService()
   
   let db = Firestore.firestore()
   
   private var usersRef: CollectionReference {
      return db.collection("users")
   }
   
   func saveProfileWith(id: String, email: String, username: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> ()) {
      guard Validators.isFilled(userName: username, description: description, sex: sex) else {
         completion(.failure(UserError.notFilled))
         return
      }
      
      let mUser = MUser(username: username!, email: email, avatarStringURL: avatarImageString!, description: description!, sex: sex!, id: id)
      
      self.usersRef.document(mUser.id).setData(mUser.representaion) { error in
         if let error = error {
            completion(.failure(error))
         } else {
            completion(.success(mUser))
         }
      }
   }
   
}
