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
    @State var animate = false
    @State var responseText = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(messages, id: \.self) { message in
                                if let message = message as? ChatPrompt {
                                    HStack {
                                        Spacer()
                                        UserMessageView(text: message.text)
                                    }
                                    .padding([.trailing, .top])

                                } else if let message = message as? ChatAnswer {
                                    ChatResponseView(message: message.text)
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 32))
                                }
                            }
                            .animation(.default)
                            .onChange(of: messages.count) { _ in
                                proxy.scrollTo(messages[messages.count - 1])
                        }
                        }
                        
                    }
                    .padding(.bottom,24)
                }
                
                ChatPromptView(text: $text, placeholder: "Ask me anything", action: sendMessage)
            }
            .onChange(of: vm.chatResponse.text) { newValue in
                let answer = ChatAnswer(id: UUID(), text: newValue, isFavorite: false)
                messages.append(answer)
            }
            .padding(.top, 10)
            .background(Color.MainChat.background)
            
            
            if vm.isFetching {
                DynamicIslandProgressView(animate: $animate)
                    .onAppear {
                        animate = true
                    }
            }
            
        }
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

struct ChatResponseView: View {
    @State var responseText = ""
    var message: String
    
    var body: some View {
        HStack {
            Text(responseText)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .onAppear {
            performTypeAnimation(on: message)
        }
    }
    
    private func performTypeAnimation(on text: String) {
        let message = text.trimmingCharacters(in: .whitespacesAndNewlines)
        for index in message.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index.utf16Offset(in: message)) * 0.03) {
                responseText += String(message[index])
            }
        }
    }
}
