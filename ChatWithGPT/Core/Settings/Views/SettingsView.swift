//
//  ProfileView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct SettingsView: View {
    /// Environment object for auth view model.
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Button { authViewModel.logout() } label: {
            Text("Logout")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
