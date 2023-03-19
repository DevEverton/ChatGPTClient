//
//  ChatPrompt.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 17/03/23.
//

import Foundation

struct ChatPrompt: ChatMessageProtocol, Hashable {
    var id: UUID
    
    let text: String
    var suggestion: ChatPromptSuggestion
}
