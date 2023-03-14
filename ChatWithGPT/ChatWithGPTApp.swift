//
//  ChatWithGPTApp.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

@main
struct ChatWithGPTApp: App {
    @StateObject var viewModel = AuthViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(viewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
