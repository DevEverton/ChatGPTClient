//
//  ChatCompletionViewModel.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import Foundation
import Combine

class ChatGPTViewModel: ObservableObject {
    @Published var chatResponse = ChatAnswer(id: UUID(), text: "")
    @Published var isFetching = false
    private let service: ChatCompletionService
    
    init(service: ChatCompletionService = ChatCompletionService()) {
        self.service = service
    }
    
    @MainActor
    func getCompletion(from prompt: String) async throws {
        isFetching = true
        defer { isFetching = false }
        let response = try await service.getChatCompletion(prompt: prompt)
        let answer = ChatAnswer(id: UUID(), text: response.choices[0].message.content)
        chatResponse = answer
    }
}
