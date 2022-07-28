//
//  MUser.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import UIKit

struct MUser: Hashable, Decodable {
   let username: String
   let avatarStringURL: String
   var id: Int
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(id)
   }
   
   static func == (lhs: MUser, rhs: MUser) -> Bool {
      return lhs.id == rhs.id
   }
   
}
