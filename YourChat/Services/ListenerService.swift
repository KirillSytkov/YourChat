//
//  ListenerService.swift
//  YourChat
//
//  Created by Kirill Sytkov on 12.08.2022.
//

import FirebaseFirestore
import FirebaseCore
import FirebaseAuth


class ListenerService {
   static let shared = ListenerService()
   
   //MARK: - Properties
   private let db = Firestore.firestore()
   private var userRef: CollectionReference {
      return db.collection(Constants.DataBaseFolders.users)
   }
   
   private var currentUserId: String {
      return Auth.auth().currentUser!.uid
   }
   
   
   //MARK: - Funcs
   func usersObserve(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
      var users = users
      let usersListener = userRef.addSnapshotListener { querySnapshot, error in
         
         guard let snapshot = querySnapshot else {
            completion(.failure(error!))
            return
         }
         
         snapshot.documentChanges.forEach { diff in
            
            guard let muser = MUser(document: diff.document) else { return }
            
            switch diff.type {
            case .added:
               guard !users.contains(muser) else { return }
               guard  muser.id != self.currentUserId else { return }
               users.append(muser)
            case .modified:
               guard let index = users.firstIndex(of: muser) else  { return }
               users[index] = muser
            case .removed:
               guard let index = users.firstIndex(of: muser) else { return }
               users.remove(at: index)
            }
         }
         completion(.success(users))
      }
      return usersListener
   }
   
   func waitingChatsObserve(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration? {
      var chats = chats
      let chatsRef = db.collection([Constants.DataBaseFolders.users, currentUserId, Constants.DataBaseFolders.waitingChats].joined(separator: "/"))
      let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
         guard let snapshot = querySnapshot else {
            completion(.failure(error!))
            return
         }
         
         snapshot.documentChanges.forEach { (diff) in
            guard let chat = MChat(document: diff.document) else { return }
            switch diff.type {
            case .added:
               guard !chats.contains(chat) else { return }
               chats.append(chat)
            case .modified:
               guard let index = chats.firstIndex(of: chat) else { return }
               chats[index] = chat
            case .removed:
               guard let index = chats.firstIndex(of: chat) else { return }
               chats.remove(at: index)
            }
         }
         completion(.success(chats))
      }
      return chatsListener
   }
   
   func activeChatsObserve(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration? {
      var chats = chats
      let chatsRef = db.collection([Constants.DataBaseFolders.users, currentUserId, Constants.DataBaseFolders.activeChats].joined(separator: "/"))
      let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
         guard let snapshot = querySnapshot else {
            completion(.failure(error!))
            return
         }
         
         snapshot.documentChanges.forEach { (diff) in
            guard let chat = MChat(document: diff.document) else { return }
            switch diff.type {
            case .added:
               guard !chats.contains(chat) else { return }
               chats.append(chat)
            case .modified:
               guard let index = chats.firstIndex(of: chat) else { return }
               chats[index] = chat
            case .removed:
               guard let index = chats.firstIndex(of: chat) else { return }
               chats.remove(at: index)
            }
         }
         completion(.success(chats))
      }
      return chatsListener
   }
   
   func messagesObserve(chat: MChat, completion: @escaping(Result<MMessage,Error>)->Void) -> ListenerRegistration? {
      let ref = userRef.document(currentUserId)
         .collection(Constants.DataBaseFolders.activeChats)
         .document(chat.friendId)
         .collection(Constants.DataBaseFolders.messages)
      let messagesListener = ref.addSnapshotListener { querySnapshot, error in
         guard let snapshot = querySnapshot else  {
            completion(.failure(error!))
            return
         }
         
         snapshot.documentChanges.forEach { diff in
            guard let message = MMessage(document: diff.document) else { return }
            
            switch diff.type {
            case .added:
               completion(.success(message))
            case .modified:
               break
            case .removed:
               break
            }
         }
      }
      return messagesListener
   }
}
