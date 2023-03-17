//
//  ChatCompletionViewModel.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import Combine

class ChatGPTViewModel: ObservableObject {
    @Published var chatResponse = ChatAnswer(text: "")
    private let service: ChatCompletionService
    
    init(service: ChatCompletionService = ChatCompletionService()) {
        self.service = service
    }
    
    @MainActor
    func getCompletion(from prompt: String) async throws {
        let response = try await service.getChatCompletion(prompt: prompt)
        var answer = ChatAnswer(text: response.choices[0].message.content)
        chatResponse = answer
    }
}
