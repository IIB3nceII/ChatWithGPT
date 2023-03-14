//
//  UserService.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation

struct UserService {
    enum UserServiceError: Error {
        case userNotFound
        case invalidAPIKey
        case userCanNotBeCreated
        case userCanNotBeDecoded
        case userCanNotBeDeleted

        var message: String {
            switch self {
            case .userNotFound:
                return "User not found!"
            case .invalidAPIKey:
                return "Invalid API key!"
            case .userCanNotBeCreated:
                return "User can not be created!"
            case .userCanNotBeDecoded:
                return "User can not be decoded!"
            case .userCanNotBeDeleted:
                return "User can not be deleted!"
            }
        }
    }

    func initUserSession() throws -> User {
        let defaults = UserDefaults.standard

        guard let data = defaults.data(forKey: "user") else {
            throw UserServiceError.userNotFound
        }

        do {
            let decoder = JSONDecoder()
            let currentUser = try decoder.decode(User.self, from: data)
            return currentUser
        } catch {
            throw UserServiceError.userCanNotBeDecoded
        }
    }

    func createUser(email: String, apiKey: String) throws -> Bool {
        let defaults = UserDefaults.standard
        let newUser = User(id: UUID().uuidString, email: email, apiKey: apiKey, lastApiKeyUpdate: Date.now)

        do {
            let encoder = JSONEncoder()
            let encodedUser = try encoder.encode(newUser)
            defaults.set(encodedUser, forKey: "user")
            return true
        } catch {
            throw UserServiceError.userCanNotBeCreated
        }
    }

    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
    }
}
