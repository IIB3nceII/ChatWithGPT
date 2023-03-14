//
//  LoginView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Text("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
