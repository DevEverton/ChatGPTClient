//
//  ChatAnswer.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 17/03/23.
//

import Foundation

struct ChatAnswer: ChatMessageProtocol, Hashable {
    var id: UUID
    
    let text: String
    var isFavorite: Bool = false
}
