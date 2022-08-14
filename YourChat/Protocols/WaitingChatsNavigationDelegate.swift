//
//  WaitingChatsNavigation.swift
//  YourChat
//
//  Created by Kirill Sytkov on 13.08.2022.
//

import Foundation

protocol WaitingChatsNavigationDelegate: AnyObject {
   func removeWaitingChat(chat:MChat)
   func chatToActive(chat:MChat)
}
