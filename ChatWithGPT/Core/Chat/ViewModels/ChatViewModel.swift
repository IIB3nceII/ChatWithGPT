//
//  ChatViewModel.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 15..
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []

    /// ChatGPTService instance.
    private let chatGPTService: ChatGPTService

    init(apiKey: String) {
        chatGPTService = ChatGPTService(apiKey: apiKey)
    }

    func sendMessage(_ message: String, completion: @escaping (Bool) -> Void) {
        messages.append(message)
        chatGPTService.getResponse(message) { response in
            switch response {
            case .success(let output):
                DispatchQueue.main.async {
                    self.messages.append(output)
                    print(self.messages)
                    print(output)
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
