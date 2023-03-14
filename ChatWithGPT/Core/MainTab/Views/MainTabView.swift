//
//  MainTabView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Text("Main tab view")
        Button { authViewModel.logout() } label: {
            Text("Logout")
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
