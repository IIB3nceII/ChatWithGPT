//
//  ChatGPTService.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation
import OpenAISwift

struct ChatGPTService {
    private var client: OpenAISwift?

    init(apiKey: String) {
        setup(apiKey: apiKey)
    }

    mutating func setup(apiKey: String) {
        client = OpenAISwift(authToken: apiKey)
    }

    func getResponse(_ input: String,
                     completion: @escaping (Result<String, Error>) -> Void)
    {
        client?.sendCompletion(with: input.trimmingCharacters(in: .whitespacesAndNewlines), completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? "Something bad happened!"
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
