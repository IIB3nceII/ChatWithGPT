//
//  ChatView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct ChatView: View {
    /// State variable to store the current value of text input.
    @State private var text: String = ""

    @ObservedObject private var chatViewModel: ChatViewModel

    init(apiKey: String) {
        chatViewModel = ChatViewModel(apiKey: apiKey)
    }

    var body: some View {
        VStack {
            headerView
            messageView
            inputView
        }
    }
}

// MARK: - Header View

extension ChatView {
    var headerView: some View {
        HStack {
            Text("ChatGPT is available")
        }
    }
}

// MARK: - Message View

extension ChatView {
    var messageView: some View {
        VStack {
            Spacer()
            LazyVStack {
                ScrollView {
                    ForEach(chatViewModel.messages, id: \.self) { message in
                        Text(message)
                    }
                }
            }
            Spacer()
        }
    }
}

// MARK: - Input View

extension ChatView {
    func handleSendMessage(_ text: String) {
        chatViewModel.sendMessage(text) { success in
            if success {
                self.text = ""
            }
        }
    }

    var inputView: some View {
        HStack(spacing: 16) {
            Image(systemName: "mic")

            TextField("type something...", text: $text)
                .submitLabel(.send)
                .onSubmit {
                    self.handleSendMessage(self.text)
                }

            Button {
                self.handleSendMessage(self.text)
            }
            label: {
                Image(systemName: "paperplane.fill")
            }
            .disabled(text == "")
        }
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(apiKey: "")
    }
}
