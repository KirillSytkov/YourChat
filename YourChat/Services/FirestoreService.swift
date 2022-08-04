//
//  FirestoreService.swift
//  YourChat
//
//  Created by Kirill Sytkov on 03.08.2022.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
   
   static let shared = FirestoreService()
   
   let db = Firestore.firestore()
   
   private var usersRef: CollectionReference {
      return db.collection("users")
   }
   
   func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
      let docRef = usersRef.document(user.uid)
      
      docRef.getDocument { document,error in
         
         if let document = document, document.exists {
            guard let muser = MUser(document: document) else {
               completion(.failure(UserError.cannotUnwrapToMUser))
               return
            }
            completion(.success(muser))
            
         } else {
            completion(.failure(UserError.cannotGetUserInfo))
         }
      }
      
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
