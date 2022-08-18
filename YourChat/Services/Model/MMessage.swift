//
//  MMessage.swift
//  YourChat
//
//  Created by Kirill Sytkov on 13.08.2022.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct ImageItem: MediaItem {
   var url: URL?
   var image: UIImage?
   var placeholderImage: UIImage
   var size: CGSize
}

struct MMessage: Hashable,MessageType {

   let content: String
   var sentDate: Date
   let id: String?
   
   var sender: SenderType
   var kind: MessageKind {
      if let image = image {
         let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
         return .photo(mediaItem)
      } else {
         return .text(content)
      }
      
   }
   var messageId: String {
      return id ?? UUID().uuidString
   }
   var image: UIImage? = nil
   var downloadURL: URL? = nil
   
   
   init(user:MUser, content: String) {
      self.content = content
      self.sender = Sender(senderId: user.id, displayName: user.username)
      self.sentDate = Date()
      self.id = nil
   }
   
   init(user: MUser, image: UIImage) {
      sender = Sender(senderId: user.id, displayName: user.username)
      self.image = image
      content = ""
      sentDate = Date()
      id = nil
   }
   
   init?(document: QueryDocumentSnapshot) {
      let data = document.data()
      guard let sentDate = data["created"] as? Timestamp else { return nil }
      guard let senderId = data["senderId"] as? String else { return nil }
      guard let senderName = data["senderName"] as? String else { return nil }
      
      self.id = document.documentID
      self.sentDate = sentDate.dateValue()
      self.sender = Sender(senderId: senderId, displayName: senderName)
      
      if let content = data["content"] as? String {
         self.content = content
         downloadURL = nil
      } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
         downloadURL = url
         self.content = ""
      } else {
         return nil
      }
      
   }
   
   var representation: [String: Any] {
      var rep: [String: Any] = [
         "created": sentDate,
         "senderId": sender.senderId,
         "senderName": sender.displayName
      ]
      
      if let url = downloadURL {
         rep["url"] = url.absoluteString
      } else {
         rep["content"] = content
      }
      
      return rep
   }
   
   func hash(into hasher: inout Hasher) {
      hasher.combine(messageId)
   }
   
   static func == (lhs: MMessage, rhs: MMessage) -> Bool {
      return lhs.messageId == rhs.messageId
   }
   
}

extension MMessage: Comparable {
   static func < (lhs: MMessage, rhs: MMessage) -> Bool {
      return lhs.sentDate < rhs.sentDate
   }
   
   
}
