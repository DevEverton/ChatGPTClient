//
//  ChatCompletionError.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import Foundation

enum ChatCompletionError: Error {
    case decoding
    case request
    case network
    case unknown
}
