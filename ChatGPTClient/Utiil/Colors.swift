//
//  Colors.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 18/03/23.
//

import SwiftUI

extension Color {
    
    struct MainChat {
        static let background = Color("background")
        static let progressView = Color("progressView")
        static let mainGreen = Color("greenChat")
    }
    
    struct Prompt {
        static let background = Color("promptBackground")
        static let text = Color("promptText")
    }
    
    struct Button {
        static let sendIcon = Color("sendIcon")
    }
    
    struct Message {
        static let gradientColors = [Color("messageGradientLeft"), Color("messageGradientRight")]
    }
}
