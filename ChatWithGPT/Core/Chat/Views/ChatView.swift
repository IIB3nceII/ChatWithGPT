//
//  ChatView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct ChatView: View {
    @AppStorage("hasApiKey") var hasApiKey: Bool = false
    @ObservedObject var viewModel = ChatViewModel()
    @FocusState var isFocus: Bool
    @State var isPresentedTipView: Bool = false
    @State private var animateMicCircle = false

    // MARK: - life cycle

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewReader in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.messages) { message in
                            MessageCellView(message: message)
                        }
                    }
                }
                .onTapGesture {
                    isFocus = false
                }
                .onChange(of: viewModel.messages.last?.text) { _ in
                    scrollToBottom(proxy: scrollViewReader)
                }
                .onChange(of: viewModel.messages.last?.errorText) { _ in
                    scrollToBottom(proxy: scrollViewReader)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    if viewModel.showMoreOptions {
                        Button {
                            viewModel.showMoreOptions.toggle()
                        } label: {
                            Image(systemName: "chevron.compact.down")
                                .padding(.vertical, 6)
                        }
                        .keyboardShortcut(.downArrow)
                    } else {
                        Button {
                            viewModel.showMoreOptions.toggle()
                        } label: {
                            Image(systemName: "chevron.compact.up")
                                .padding(.vertical, 6)
                        }
                        .keyboardShortcut(.upArrow)
                    }

                    Spacer()
                }
                if viewModel.showMoreOptions {
                    HStack {
                        VoicePicker(selectedVoice: $viewModel.selectedVoice)
                        muteButton
                    }
                }

                HStack {
                    Button {
                        viewModel.clearMessages()
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .tint(.blue)
                    .keyboardShortcut("d")
                    if viewModel.showMoreOptions == false {
                        muteButton
                    }
                    micButton
                    Group {
                        if #available(iOS 16.0, macOS 13.0, *) {
                            TextField("prompt", text: $viewModel.prompt, axis: .vertical)
                                .lineLimit(1 ... 5)
                        } else {
                            TextField("prompt", text: $viewModel.prompt)
                        }
                    }
                    .onSubmit {
                        viewModel.requestAI()
                    }
                    .focused($isFocus)
                    .textFieldStyle(.roundedBorder)
                    Button {
                        isFocus = false
                        viewModel.requestAI()
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .padding()
        .tint(.blue)
    }

    var muteButton: some View {
        Button {
            viewModel.isEnableSpeech.toggle()
        } label: {
            if viewModel.isEnableSpeech {
                Image(systemName: "speaker.wave.2.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                Image(systemName: "speaker.slash.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .tint(.blue)
    }

    var micButton: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.red.opacity(0.3))
                .frame(width: 50, height: 50)
                .scaleEffect(animateMicCircle ? 0.9 : 1.2)
                .animation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: false), value: animateMicCircle)
                .onAppear {
                    self.animateMicCircle.toggle()
                }
                .opacity(viewModel.isRecording ? 1 : 0)
            Button {
                if viewModel.isRecording {
                    viewModel.stopSpeechRecognizer()
                } else {
                    isFocus = false
                    viewModel.startSpeechRecognizer()
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(viewModel.isRecording ? .red : .blue)

                    Image(systemName: "mic").foregroundColor(.white)
                }
            }
        }
        .buttonStyle(.borderless)
        .frame(width: 60, height: 50)
        .keyboardShortcut("m", modifiers: .shift)
    }

    // MARK: - private methods

    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = viewModel.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
