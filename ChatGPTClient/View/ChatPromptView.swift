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
                .padding(8)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .background(.white)
                .cornerRadius(24)
            
            Button(action: action) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemGray).opacity(0.2))
    }
}

struct ChatPromptView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ChatPromptView(text: .constant("Testing"), placeholder: "How can I help?", action: {})
        }
    }
}
