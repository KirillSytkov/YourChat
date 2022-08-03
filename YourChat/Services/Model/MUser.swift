//
//  MUser.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import UIKit

struct MUser: Hashable, Decodable {
   let username: String
   let email: String
   let avatarStringURL: String
   let description: String
   let sex: String
   var id: String
   
   var representaion:[String: Any] {
      var rep = ["username": username]
      rep["sex"] = sex
      rep["email"] = email
      rep["avatarStringURL"] = avatarStringURL
      rep["description"] = description
      rep["uid"] = id
      return rep
   }
   
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(id)
   }
   
   static func == (lhs: MUser, rhs: MUser) -> Bool {
      return lhs.id == rhs.id
   }
   
   
   func contains(filter: String?) -> Bool {
      guard let filter = filter else { return true }
      if filter.isEmpty { return true}
      
      let lowercasedFilter = filter.lowercased()
      return username.lowercased().contains(lowercasedFilter)
   }
}