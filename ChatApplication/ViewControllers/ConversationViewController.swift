//
//  ConversationViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/26/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView


class ConversationViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "OPSolutions")
    let otherUser = Sender(senderId: "other", displayName: "Mark Allen")
    
    var messages = [MessageType]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleLastMessages()
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
    }
    
    fileprivate func sampleLastMessages() {
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-80000),
                                kind: .text("Hello Allen")))
        messages.append(Message(sender: otherUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-70000),
                                kind: .text("Yooooooooooooooo")))
        messages.append(Message(sender: currentUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-60000),
                                kind: .text("HOW areeeeeeeeeee you? (this is loooooooooooooooooooooooooooooooooooooooooooooong message)")))
        messages.append(Message(sender: otherUser,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-50000),
                                kind: .text("2021-08-26 10:54:16.186175+0800 ChatApplication[5107:174692] 8.5.0 - [Firebase/Analytics][I-ACS023220] Analytics screen reporting is enabled. Call +[FIRAnalytics logEventWithName:FIREventScreenView parameters:] to log a screen view event. To disable automatic screen reporting, set the flag FirebaseAutomaticScreenReportingEnabled to NO (boolean) in the Info.plist")))
        
        messages.append(Message(sender: currentUser,
                                messageId: "5",
                                sentDate: Date().addingTimeInterval(-40000),
                                kind: .text("ok this is my last messages")))
        messages.append(Message(sender: otherUser,
                                messageId: "6",
                                sentDate: Date().addingTimeInterval(-30000),
                                kind: .text("ok then good bye")))
    }
    func currentSender() -> SenderType {
    return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}

extension ConversationViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
    }
}

