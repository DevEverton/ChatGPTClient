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
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                .padding()
        }
        .background(LinearGradient(
            gradient: Gradient(colors: Color.Message.gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .cornerRadius(18, corners: [.topRight, .bottomLeft, .bottomRight])
    }
}

struct UserMessageView_Previews: PreviewProvider {
    static var previews: some View {
        UserMessageView(text: "Example message")
            .frame(width: 400, height: 30)
    }
}
