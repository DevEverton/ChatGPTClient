//
//  ChatCompletionService.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import Foundation

class ChatCompletionService: ChatCompletionServiceProtocol {
    var url = "https://api.openai.com/v1/chat/completions"
    let apiKey = "ENTER YOUR API KEY HERE"
    
    func getChatCompletion(prompt: String) async throws -> ChatCompletionResponse {
        guard let url = URL(string: url) else {
            throw ChatCompletionError.request
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": prompt]]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            throw ChatCompletionError.unknown
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ChatCompletionError.request
        }
        guard let decodedResponse = try? JSONDecoder().decode(ChatCompletionResponse.self, from: data) else {
            throw ChatCompletionError.decoding
        }
        return decodedResponse
    }
}
