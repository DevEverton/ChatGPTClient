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
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messages, id: \.self) { message in
                            if let message = message as? ChatPrompt {
                                HStack {
                                    Spacer()
                                    UserMessageView(text: message.text)
                                        .padding([.trailing, .top])
                                }
                                
                            } else if let message = message as? ChatAnswer {
                                HStack {
                                    Text(message.text)
                                        .font(.system(size: 16, weight: .light, design: .rounded))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 32))
                                    
                                    Spacer()
                                }
                            }
                        }
                        .animation(.default)
                        .onChange(of: messages.count) { _ in
                            proxy.scrollTo(messages.count - 1)
                        }
                        
                    }
                    .padding(.bottom,24)
                }
                
                ChatPromptView(text: $text, placeholder: "Type a message", action: sendMessage)
            }
            .onChange(of: vm.chatResponse.text) { newValue in
                let answer = ChatAnswer(id: UUID(), text: newValue, isFavorite: false)
                messages.append(answer)
                
            }
            .padding(.top)
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

struct DynamicIslandProgressView: View {
    @Binding var animate: Bool
    @State var width: CGFloat = 125.5
    @State var height: CGFloat = 36
    @State var paddingTop: CGFloat = 11
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.MainChat.mainGreen)
                .frame(width: width, height: height)
                .padding(.top, paddingTop)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                width = 135
                height = 44
                paddingTop = 8.1
            }
        }
        
    }
}
