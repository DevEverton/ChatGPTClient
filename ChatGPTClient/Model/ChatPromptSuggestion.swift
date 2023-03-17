//
//  ChatPromptSuggestion.swift
//  ChatGPTClient
//
//  Created by Everton Carneiro on 17/03/23.
//

import Foundation

enum ChatPromptSuggestion: String {
    case empty = ""
    case likeFive = "Explain it like I'm 5 "
    case rewriteProfessional = "Rewrite the following text in a more professional way:"
    case rewriteCasual = "Rewrite the following text in a more casual way:"
    case rewriteConcise = "Rewrite the following text in a more concise way:"
    case summary = "Summarize the following text:"
}
