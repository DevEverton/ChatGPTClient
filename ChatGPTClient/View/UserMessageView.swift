//
//  UserMessageView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 18/03/23.
//

import SwiftUI

struct UserMessageView: View {
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
        }
        .background(LinearGradient(
            gradient: Gradient(colors: Color.Message.gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .cornerRadius(18, corners: [.topLeft, .topRight, .bottomLeft])
    }
}

struct UserMessageView_Previews: PreviewProvider {
    static var previews: some View {
        UserMessageView(text: "Example message")
            .frame(width: 400, height: 30)
    }
}
