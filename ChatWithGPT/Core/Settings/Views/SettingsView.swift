//
//  ProfileView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var chatViewModel = ChatViewModel()

    @AppStorage("apiKey") var apiKey: String = ""

    var body: some View {
        VStack {
            VoicePicker(selectedVoice: $chatViewModel.selectedVoice)

            TextField("API key", text: $apiKey)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
