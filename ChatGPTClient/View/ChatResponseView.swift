//
//  ChatResponseView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 21/03/23.
//

import SwiftUI
import MarkdownView

struct ChatResponseView: View {
    @State var responseText = ""
    @State var charCount = 0
    var message: String
    var scrollUpCallback: (() -> Void)
    
    var body: some View {
        HStack {
            MarkdownView(text: $responseText)
                .font(.system(size: 16, weight: .thin, design: .rounded), for: .body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.bottom, 8)
        .onAppear {
            DispatchQueue.main.async {
                performTypeAnimation(on: message)
            }
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        scrollUpCallback()
                    }
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

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
