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

    let userService = UserService()

    init() {
        self.initUserSession()
    }

    deinit {
        reset()
    }

    func createUser(email: String, apiKey: String) {
        do {
            let isUserCreated = try self.userService.createUser(email: email, apiKey: apiKey)

            if isUserCreated {
                self.initUserSession()
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }

    func logout() {
        self.userService.logout()
        self.reset()
    }

    private func initUserSession() {
        do {
            self.user = try self.userService.initUserSession()
            self.isAuthenticated = true
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    private func reset() {
        self.user = nil
        self.isAuthenticated = false
    }
}
