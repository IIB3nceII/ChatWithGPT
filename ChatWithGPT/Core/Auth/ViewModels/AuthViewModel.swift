//
//  AuthViewModel.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isAuthenticated: Bool = false

    init() {
        self.initUserSession()
    }

    deinit {
        reset()
    }

    private func initUserSession() {
        let defaults = UserDefaults.standard

        guard let currentUser = defaults.object(forKey: "user") as? User else { return }

        self.user = currentUser
        self.isAuthenticated = true
    }

    private func reset() {
        self.user = nil
        self.isAuthenticated = false
    }
}
