//
//  LoginView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import Foundation
import SwiftUI

struct LoginView: View {
    @AppStorage("apiKey") var apiKey: String = ""
    @AppStorage("hasApiKey") var hasApiKey: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Hi, there").font(.title)

            HStack {
                TextField("API key", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if let string = getClipboardString(),
                       string.isEmpty == false
                    {
                        apiKey = string
                    }
                } label: {
                    Image(systemName: "doc.on.clipboard")
                }
                .buttonStyle(.borderedProminent)
            }

            HStack {
                Spacer()
                Button {
                    if apiKey.isEmpty == false {
                        hasApiKey = true
                    }
                } label: {
                    Text("Submit")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .padding()
        .tint(.blue)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
