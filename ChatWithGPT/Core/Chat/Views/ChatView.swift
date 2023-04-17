//
//  ChatView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct ChatView: View {
    @AppStorage("hasApiKey") var hasApiKey: Bool = false
    @ObservedObject var chatViewModel = ChatViewModel()
    @FocusState var isFocus: Bool
    @State var isPresentedTipView: Bool = false
    @State private var animateMicCircle = false

    private let iconSize: CGFloat = 24

    init() {
        chatViewModel.messages.append(Message(role: .system, text: "Hi, How can I help you today?", isInteracting: false, errorText: ""))
    }

    // MARK: - life cycle

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewReader in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(chatViewModel.messages) { message in
                            MessageCellView(message: message)
                        }
                    }
                }
                .onTapGesture {
                    isFocus = false
                }
                .onChange(of: chatViewModel.messages.last?.text) { _ in
                    scrollToBottom(proxy: scrollViewReader)
                }
                .onChange(of: chatViewModel.messages.last?.errorText) { _ in
                    scrollToBottom(proxy: scrollViewReader)
                }
            }
            HStack {
                Button {
                    chatViewModel.clearMessages()
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                }
                .tint(.blue)
                .keyboardShortcut("d")

                muteButton

                micButton
                Group {
                    if #available(iOS 16.0, macOS 13.0, *) {
                        TextField("Aa", text: $chatViewModel.prompt, axis: .vertical)
                            .lineLimit(1 ... 5)
                    } else {
                        TextField("Aa", text: $chatViewModel.prompt)
                    }
                }
                .onSubmit {
                    chatViewModel.requestAI()
                }
                .focused($isFocus)
                .textFieldStyle(.roundedBorder)
                Button {
                    isFocus = false
                    chatViewModel.requestAI()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                }
            }
            .disabled(chatViewModel.isLoading)
        }
        .padding()
        .tint(.blue)
    }

    var muteButton: some View {
        Button {
            chatViewModel.isEnableSpeech.toggle()
        } label: {
            if chatViewModel.isEnableSpeech {
                Image(systemName: "speaker.wave.2.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
            } else {
                Image(systemName: "speaker.slash.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
            }
        }
        .tint(.blue)
    }

    var micButton: some View {
        Button {
            if chatViewModel.isRecording {
                chatViewModel.stopSpeechRecognizer()
            } else {
                isFocus = false
                chatViewModel.startSpeechRecognizer()
            }
        } label: {
            if chatViewModel.isRecording {
                Image(systemName: "mic.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
            } else {
                Image(systemName: "mic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
            }
        }
        .tint(.blue)
        .keyboardShortcut("m", modifiers: .shift)
    }

    // MARK: - private methods

    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = chatViewModel.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
