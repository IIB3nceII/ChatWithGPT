//
//  ChatWithGPTApp.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

@main
struct ChatWithGPTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
