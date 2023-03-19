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
    @State private var messages: [AnyHashable] = []

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if let message = message as? ChatPrompt {
                        HStack {
                            Spacer()
                            UserMessageView(text: message.text)
                        }
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                    } else if let message = message as? ChatAnswer {
                        HStack {
                            Text(message.text)
                                .font(.system(size: 16, weight: .light, design: .rounded))                            .padding(.horizontal, 12)
                        }
                        .padding(.trailing)
                    }
                }
            }
            
            ChatPromptView(text: $text, placeholder: "Type a message", action: sendMessage)
        }
        .onChange(of: vm.chatResponse.text) { newValue in
            let answer = ChatAnswer(id: UUID(), text: newValue, isFavorite: false)
            messages.append(answer)
            
        }
        .background(Color.MainChat.background)        
    }
    
    private func sendMessage() {
        let prompt = ChatPrompt(id: UUID(), text: text, suggestion: .empty)
        messages.append(prompt)
        text = ""
        Task {
            try? await vm.getCompletion(from: prompt.text)
        }
    }
}

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
            .environmentObject(ChatGPTViewModel())
    }
}
