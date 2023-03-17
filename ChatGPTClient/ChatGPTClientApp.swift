//
//  ChatGPTClientApp.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 16/03/23.
//

import SwiftUI

@main
struct ChatGPTClientApp: App {
    @StateObject private var chatViewModel = ChatGPTViewModel()

    var body: some Scene {
        WindowGroup {
            MainChatView()
                .environmentObject(chatViewModel)
        }
    }
}
