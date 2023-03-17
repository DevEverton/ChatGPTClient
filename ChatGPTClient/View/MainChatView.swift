//
//  MainChatView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 17/03/23.
//

import SwiftUI

struct MainChatView: View {
    @EnvironmentObject var vm: ChatGPTViewModel

    @State private var text = ""
    @State private var messages: [String] = []

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
            }

            ChatPromptView(text: $text, placeholder: "Type a message", action: sendMessage)
        }
        .onChange(of: vm.chatResponse.text) { newValue in
            messages.append(newValue)

        }
    }

    private func sendMessage() {
        messages.append(text)
        text = ""
        Task {
            try? await vm.getCompletion(from: "text")
        }
    }
}

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
    }
}
