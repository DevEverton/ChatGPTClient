//
//  ChatPromptView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 17/03/23.
//

import SwiftUI

struct ChatPromptView: View {
    @Binding var text: String
    let placeholder: String
    let action: () -> Void

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(12)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color.Prompt.text)
                .background(.white)
            
            Button(action: action) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.Button.sendIcon)
            }
            .padding(12)
        }
        .background(.white)
        .cornerRadius(8)
        .frame(height: 30)
        .padding([.bottom, .horizontal], 12)
    }
}

struct ChatPromptView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ChatPromptView(text: .constant("Testing"), placeholder: "How can I help?", action: {})
        }
        .background(Color.MainChat.background)
    }
}
