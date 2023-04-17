//
//  ChatWithGPTApp.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

@main
struct ChatWithGPTApp: App {
    @AppStorage("hasApiKey") var hasApiKey: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasApiKey {
                    ContentView()
                } else {
                    LoginView()
                }
            }
        }
    }
}
