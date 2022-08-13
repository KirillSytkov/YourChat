//
//  MMessage.swift
//  YourChat
//
//  Created by Kirill Sytkov on 13.08.2022.
//

import UIKit

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
