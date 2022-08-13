//
//  MChatModel.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
   let friendUsername: String
   let friendAvatarStringURL: String
   let lastMessageContent: String
   var friendId: String
   
   var representation: [String: Any] {
      var rep = ["friendUserName" : friendUsername]
      rep["friednAvatarStringURL"] = friendAvatarStringURL
      rep["lastMessageContent"] =  lastMessageContent
      rep["friendId"] = friendId
      return rep
   }
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(friendId)
   }
   
   static func == (lhs: MChat, rhs: MChat) -> Bool {
      return lhs.friendId == rhs.friendId
   }
   
}
