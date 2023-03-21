//
//  DynamicIslandProgressView.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 21/03/23.
//

import SwiftUI

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

struct DynamicIslandProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandProgressView(animate: .constant(true))
    }
}
