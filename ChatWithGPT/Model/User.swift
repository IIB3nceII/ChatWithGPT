//
//  File.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation

struct User: Codable {
    let id: String
    var email: String
    var apiKey: String
    var lastApiKeyUpdate: Date
}
