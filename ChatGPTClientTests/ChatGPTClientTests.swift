//
//  ChatGPTClientTests.swift
//  ChatGPTClientTests
//
//  Created by Everton Carneiro on 21/03/23.
//

import XCTest
@testable import ChatGPTClient


class MockChatCompletionService: ChatCompletionServiceProtocol {
    var url: String = "mockApiKey"
    var getChatCompletionCalled = false
    
    func getChatCompletion(prompt: String) async throws -> ChatCompletionResponse {
        getChatCompletionCalled = true
        
        let mockResponse = ChatCompletionResponse(
            id: "chatcmpl-6wapSgG2JDsnFnXpc05mQNMqsLsvS",
            object: "chat.completion",
            created: 1679422614,
            choices: [
                Choice(
                    index: 0,
                    message: Message(
                        role: "assistant",
                        content: "\n\nI'm great! How are you?"
                    ),
                    finishReason: "stop"
                )
            ],
            usage: Usage(
                promptTokens: 13,
                completionTokens: 18,
                totalTokens: 31
            )
        )

        return mockResponse
    }
}

class ChatGPTClientTests: XCTestCase {
    var sut: ChatCompletionServiceProtocol!
    var mockService: MockChatCompletionService!
    
    override func setUpWithError() throws {
        mockService = MockChatCompletionService()
        sut = mockService
    }

    override func tearDownWithError() throws {
        mockService = nil
        sut = nil
    }

    func testGetChatCompletion() async throws {
        let prompt = "Hello, how are you?"
        let response = try await sut.getChatCompletion(prompt: prompt)
        
        XCTAssert(mockService.getChatCompletionCalled)
        XCTAssertNotNil(response)
        XCTAssertNotNil(response.choices)
        XCTAssertFalse(response.choices.isEmpty)
    }
}

