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
   
   //MARK: - Properties
   private let db = Firestore.firestore()
   
   private var usersRef: CollectionReference {
      return db.collection(Constants.DataBaseFolders.users)
   }
   
   private var waitingChatsRef: CollectionReference {
      return db.collection([Constants.DataBaseFolders.users, currentUser.id, Constants.DataBaseFolders.waitingChats].joined(separator: "/"))
   }
   
   private var activeChatsRef: CollectionReference {
      return db.collection([Constants.DataBaseFolders.users, currentUser.id, Constants.DataBaseFolders.activeChats].joined(separator: "/"))
   }
   
   private var currentUser: MUser!
   
   
   //MARK: - funcs
   func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
      let docRef = usersRef.document(user.uid)
      docRef.getDocument { (document, error) in
         if let document = document, document.exists {
            guard let muser = MUser(document: document) else {
               completion(.failure(UserError.cannotUnwrapToMUser))
               return
            }
            self.currentUser = muser
            completion(.success(muser))
         } else {
            completion(.failure(UserError.cannotGetUserInfo))
         }
      }
   }
   
   func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
      
      guard Validators.isFilled(userName: username, description: description, sex: sex) else {
         completion(.failure(UserError.notFilled))
         return
      }
      
      guard avatarImage != UIImage(named: Constants.Images.avatarImage) else {
         completion(.failure(UserError.photoNotExist))
         return
      }
      
      var muser = MUser(username: username!,
                        email: email,
                        avatarStringURL: "not exist",
                        description: description!,
                        sex: sex!,
                        id: id)
      
      StorageService.shared.upload(photo: avatarImage!) { result in
         switch result {
         case .success(let url):
            muser.avatarStringURL = url.absoluteString
            self.usersRef.document(muser.id).setData(muser.representation) { error in
               if let error = error {
                  completion(.failure(error))
               } else {
                  self.currentUser = muser
                  completion(.success(muser))
               }
            }
         case .failure(let error):
            completion(.failure(error))
         }
      }
   }
   
   func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
      let reference = db.collection([Constants.DataBaseFolders.users, receiver.id, Constants.DataBaseFolders.waitingChats].joined(separator: "/"))
      let messageRef = reference.document(self.currentUser.id).collection(Constants.DataBaseFolders.messages)
      let message = MMessage(user: currentUser, content: message)
      let chat = MChat(friendUsername: currentUser.username,
                       friendAvatarStringURL: currentUser.avatarStringURL,
                       friendId: currentUser.id, lastMessageContent: message.content)
      
      reference.document(currentUser.id).setData(chat.representation) { error in
         if let error = error {
            completion(.failure(error))
            return
         }
         messageRef.addDocument(data: message.representation) { error in
            if let error = error {
               completion(.failure(error))
               return
            }
            completion(.success(Void()))
         }
      }
   }
   
   func deleteWaitingChat(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
      waitingChatsRef.document(chat.friendId).delete { error in
         if let error = error {
            completion(.failure(error))
            return
         }
         self.deleteMessages(chat: chat, completion: completion)
      }
   }
   
   func deleteMessages(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
      let reference = waitingChatsRef.document(chat.friendId).collection(Constants.DataBaseFolders.messages)
      
      getWaitingChatMessages(chat: chat) { result in
         switch result {
         case .success(let messages):
            for message in messages {
               guard let documentId = message.id else { return }
               let messageRef = reference.document(documentId)
               messageRef.delete { (error) in
                  if let error = error {
                     completion(.failure(error))
                     return
                  }
                  completion(.success(Void()))
               }
            }
         case .failure(let error):
            completion(.failure(error))
         }
      }
   }
   
   func getWaitingChatMessages(chat: MChat, completion: @escaping (Result<[MMessage], Error>) -> Void) {
      let reference = waitingChatsRef.document(chat.friendId).collection(Constants.DataBaseFolders.messages)
      var messages = [MMessage]()
      
      reference.getDocuments { querySnapshot, error in
         if let error = error {
            completion(.failure(error))
            return
         }
         for document in querySnapshot!.documents {
            guard let message = MMessage(document: document) else { return }
            messages.append(message)
         }
         completion(.success(messages))
      }
   }
   
   func changeToActive(chat: MChat, completion: @escaping (Result<Void, Error>)-> Void) {
      getWaitingChatMessages(chat: chat) { result in
         switch result {
         case .success(let messages):
            self.deleteWaitingChat(chat: chat) { result in
               switch result {
               case .success():
                  self.createActiveChat(chat: chat, messages: messages) { result in
                     switch result {
                     case .success():
                        completion(.success(()))
                     case .failure(let error):
                        completion(.failure(error))
                     }
                  }
               case .failure(let error):
                  completion(.failure(error))
               }
            }
         case .failure(let error):
            completion(.failure(error))
         }
      }
   }
   
   func createActiveChat(chat:MChat, messages: [MMessage], completion: @escaping (Result<Void, Error>)->Void ) {
      let messageRef = activeChatsRef.document(chat.friendId).collection(Constants.DataBaseFolders.messages)
      
      activeChatsRef.document(chat.friendId).setData(chat.representation) { error in
         if let error = error {
            completion(.failure(error))
            return
         }
         for message in messages {
            messageRef.addDocument(data: message.representation) { error in
               if let error = error {
                  completion(.failure(error))
                  return
               }
               completion(.success(()))
            }
         }
      }
   }
   
   func sendMessage(chat: MChat, message: MMessage, completion: @escaping (Result<Void, Error>)->Void ) {
      let friendRef = usersRef.document(chat.friendId)
         .collection(Constants.DataBaseFolders.activeChats)
         .document(currentUser.id)
      
      let friendMessageRef = friendRef.collection(Constants.DataBaseFolders.messages)
      
      let myMessageRef = usersRef.document(currentUser.id)
         .collection(Constants.DataBaseFolders.activeChats)
         .document(chat.friendId)
         .collection(Constants.DataBaseFolders.messages)
      
      let chatForFriend = MChat(friendUsername: currentUser.username,
                                friendAvatarStringURL: currentUser.avatarStringURL,
                                friendId: currentUser.id,
                                lastMessageContent: message.content)
      
      friendRef.setData(chatForFriend.representation) { error in
         if let error = error {
            completion(.failure(error))
            return
         }
         friendMessageRef.addDocument(data: message.representation) { error in
            if let error = error {
               completion(.failure(error))
               return
            }
            myMessageRef.addDocument(data: message.representation) { error in
               if let error = error {
                  completion(.failure(error))
                  return
               }
               completion(.success(()))
            }
         }
      }
   }
}

