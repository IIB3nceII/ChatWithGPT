//
//  MessageCellView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 04. 17..
//

import SwiftUI

struct MessageCellView: View {
    var message: Message? = nil

    var body: some View {
        if let message = message {
            HStack(alignment: .bottom) {
                if message.role == .user {
                    Spacer()
                }

                if message.role == .system {
                    Image(systemName: "person.icloud")
                        .font(.headline)
                }

                VStack(alignment: .leading) {
                    Text(message.text)
                    if message.errorText != "" {
                        Text(message.errorText)
                            .foregroundColor(Color.pink)
                    }
                    if message.isInteracting && message.role == .system {
                        LoadingView()
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(14)

                if message.role == .user {
                    Image(systemName: "person.circle")
                        .font(.headline)
                }

                if message.role == .system {
                    Spacer()
                }
            }
            .onTapGesture {
                copyToClipboard(text: message.text.trimmed)
            }
        } else {
            Text("No message")
        }
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView(message: .init(role: .user, text: "Example message.", isInteracting: false, errorText: ""))
    }
}
