//
//  Message.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 04. 16..
//

import Foundation

struct Message: Identifiable {
    enum Role: String {
        case user, system
    }

    let id: UUID = .init()
    let role: Role
    var text: String

    var isInteracting: Bool
    var errorText: String
}
