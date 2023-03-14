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
                    Text("ChatGPT is available")
                }
            }
            Spacer()
        }
    }
}

// MARK: - Input View

extension ChatView {
    var inputView: some View {
        HStack(spacing: 16) {
            Image(systemName: "mic")

            TextField("type something...", text: $text)
                .submitLabel(.send)
                .onSubmit {
                    print("Send")
                }

            Button {
                print("Send")
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
        ChatView()
    }
}
