//
//  MainTabView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct MainTabView: View {
    /// Environment object for auth view model.
    @EnvironmentObject private var authViewModel: AuthViewModel

    /// State variable to store the current tab index.
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            ChatView(apiKey: authViewModel.user?.apiKey ?? "")
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "message.fill")
                }.tag(0)

            SettingsView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "transmission")
                }.tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
