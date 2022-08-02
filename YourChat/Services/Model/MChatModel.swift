//
//  MChatModel.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
   let username: String
   let userImageString: String
   let lastMessage: String
   var id: Int
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(id)
   }
   
   static func == (lhs: MChat, rhs: MChat) -> Bool {
      return lhs.id == rhs.id
   }
   
}
