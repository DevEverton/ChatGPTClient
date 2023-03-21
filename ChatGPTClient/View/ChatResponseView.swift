//
//  ChatResponseView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 21/03/23.
//

import SwiftUI

struct ChatResponseView: View {
    @State var responseText = ""
    @State var charCount = 0
    var message: String
    var scrollUpCallback: (() -> Void)
    
    var body: some View {
        HStack {
            Text(responseText)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.bottom, 8)
        .onAppear {
            performTypeAnimation(on: message)
        }
    }
    
    private func performTypeAnimation(on text: String) {
        let message = text.trimmingCharacters(in: .whitespacesAndNewlines)
        scrollUpCallback()

        for index in message.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index.utf16Offset(in: message)) * 0.03) {
                responseText += String(message[index])
                if responseText.count > charCount + 100 {
                    scrollUpCallback()
                    charCount = responseText.count
                }
                if message.count == responseText.count {
                    scrollUpCallback()
                }
            }
        }
    }
}


struct ChatResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ChatResponseView(message: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...", scrollUpCallback: {})
    }
}
