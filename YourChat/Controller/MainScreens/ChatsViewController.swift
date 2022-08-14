//
//  ChatsViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 14.08.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
class ChatsViewController: MessagesViewController {

   //MARK: - Properties
   private let user: MUser
   private let chat: MChat
   private var messages:[MMessage] = []
   
   init(user:MUser, chat: MChat) {
      self.user = user
      self.chat = chat
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   //MARK: - Lyficycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      configureMessageTextField()
      configureSendButton()
      
   }
   
   
   //MARK: - Flow func
   private func setup() {
      self.title = chat.friendUsername
      messagesCollectionView.backgroundColor = .systemGray6
      
      messageInputBar.delegate = self
      messagesCollectionView.messagesDataSource = self
      messagesCollectionView.messagesLayoutDelegate = self
      messagesCollectionView.messagesDisplayDelegate = self
      
      if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.textMessageSizeCalculator.incomingAvatarSize = .zero
      }
   }
   
   private func configureMessageTextField() {
      messageInputBar.isTranslucent = true
      messageInputBar.separatorLine.isHidden = true
      messageInputBar.backgroundView.backgroundColor = .white
      messageInputBar.inputTextView.backgroundColor = .white
      messageInputBar.inputTextView.placeholderTextColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
      messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: 36)
      messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
      messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 0.4033635232)
      messageInputBar.inputTextView.layer.borderWidth = 0.2
      messageInputBar.inputTextView.layer.cornerRadius = 18.0
      messageInputBar.inputTextView.layer.masksToBounds = true
      messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
      
      
      messageInputBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      messageInputBar.layer.shadowRadius = 5
      messageInputBar.layer.shadowOpacity = 0.3
      messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
      
   }
   
   private func configureSendButton() {
       messageInputBar.sendButton.setImage(UIImage(named: "Sent"), for: .normal)
       messageInputBar.sendButton.applyGradients(cornerRadius: 10)
       messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
       messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 30)
       messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
       messageInputBar.middleContentViewPadding.right = -38
   }
   
   private func insertNewMessage(message: MMessage) {
      guard !messages.contains(message) else { return }
      messages.append(message)
      messages.sort()
      
      messagesCollectionView.reloadData()
   }
}


//MARK: - Extensions

//MARK: - MessagesDataSource
public struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}

extension ChatsViewController:MessagesDataSource {
   func currentSender() -> SenderType {
      return Sender(senderId: user.id, displayName: user.username)
   }
   
   func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
      messages[indexPath.item]
   }
   
   func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
      1
   }
   
   func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
      messages.count
   }
   
   
}

extension ChatsViewController: MessagesLayoutDelegate {
   func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
      return CGSize(width: 0, height: 8)
   }
}

extension ChatsViewController: MessagesDisplayDelegate {
   func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
      return isFromCurrentSender(message: message) ? .white : .systemPink
   }
   
   func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
      return isFromCurrentSender(message: message) ? .darkGray : .white
   }
   
   func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
      avatarView.isHidden = true
      
   }
   
   func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
      return .bubble
   }
   
}

extension ChatsViewController:  InputBarAccessoryViewDelegate {
   
   func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
      let message = MMessage(user: user, content: text)
      insertNewMessage(message: message)
      inputBar.inputTextView.text = ""
      
   }
   
//   func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {
//      <#code#>
//   }
//
//   func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
//      <#code#>
//   }
//
//   func inputBar(_ inputBar: InputBarAccessoryView, didSwipeTextViewWith gesture: UISwipeGestureRecognizer) {
//      <#code#>
//   }
//
}

