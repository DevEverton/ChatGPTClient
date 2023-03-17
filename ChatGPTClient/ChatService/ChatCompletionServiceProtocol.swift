//
//  ChatCompletionServiceProtocol.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import Foundation

protocol ChatCompletionServiceProtocol {
    func getChatCompletion(prompt: String) async throws -> ChatCompletionResponse 
}
