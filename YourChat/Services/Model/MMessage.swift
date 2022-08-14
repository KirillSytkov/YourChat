//
//  MMessage.swift
//  YourChat
//
//  Created by Kirill Sytkov on 13.08.2022.
//

import UIKit
import FirebaseFirestore

struct MMessage: Hashable {
   let content: String
   let senderId: String
   let senderUserName: String
   var sentDate: Date
   let id: String?
   
   
   init(user:MUser, content: String) {
      self.content = content
      self.senderId = user.id
      self.senderUserName = user.username
      self.sentDate = Date()
      self.id = nil
   }
   
   init?(document: QueryDocumentSnapshot) {
      let data = document.data()
      guard let sentDate = data["created"] as? Timestamp else { return nil }
      guard let senderId = data["senderId"] as? String else { return nil }
      guard let senderName = data["senderName"] as? String else { return nil }
      guard let content = data["content"] as? String else { return nil }
      
      self.id = document.documentID
      self.sentDate = sentDate.dateValue()
      self.senderId = senderId
      self.senderUserName = senderName
      self.content = content
   }
   
   var representation: [String: Any] {
      let rep: [String: Any] = [
         "created": sentDate,
         "senderId": senderId,
         "senderName": senderUserName,
         "content": content
      ]
      return rep
   }
   
}
