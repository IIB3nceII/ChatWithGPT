//
//  LoginView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation
import SwiftUI

struct LoginView: View {
    /// Env object for auth view model.
    @EnvironmentObject private var authViewModel: AuthViewModel

    /// State var to store the email address of the user.
    @State private var email = ""

    /// State var to store the api key of the user.
    @State private var apiKey = ""

    var body: some View {
        VStack {
            VStack(spacing: 14) {
                FormInputField(text: $email, placeholderText: "Email...")
                FormInputField(text: $apiKey, placeholderText: "API key...")

                Button {
                    authViewModel.createUser(email: email, apiKey: apiKey)
                } label: {
                    Text("Let's chat!")
                }
            }

            // TODO: Uncomment if user management available.
//            NavigationLink{
//                RegistrationView()
//            }label: {
//                Text("Do not have an account?")
//            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
