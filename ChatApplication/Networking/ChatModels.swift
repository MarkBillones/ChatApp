//
//  ChatModels.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/26/21.
//

import Foundation
import MessageKit

//model objects
struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
