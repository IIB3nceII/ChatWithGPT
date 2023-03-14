//
//  AuthViewModel.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation

class AuthViewModel: ObservableObject {
    /// Published variable of the current user.
    @Published var user: User? = nil

    /// Published variable, true if user authenticated.
    @Published var isAuthenticated: Bool = false

    /// User service instance.
    private let userService = UserService()

    /// Init calls the ``initUserSession()`` method.
    init() {
        self.initUserSession()
    }

    /// De init calls the ``reset()``.
    deinit {
        reset()
    }

    /// Uses the user service to create a new user in the data store.
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

    /// Use the user service ``logout()`` to handle user logout.
    func logout() {
        self.userService.logout()
        self.reset()
    }

    /// Call the user service ``initUserSession()`` to get the current user.
    private func initUserSession() {
        do {
            self.user = try self.userService.initUserSession()
            self.isAuthenticated = true
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    /// Reset the view model state.
    private func reset() {
        self.user = nil
        self.isAuthenticated = false
    }
}
