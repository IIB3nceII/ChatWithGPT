//
//  ForminputField.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 03. 14..
//

import SwiftUI

struct FormInputField: View {
    /// Binding to store the current value of the field.
    @Binding var text: String

    /// Placeholder text of the input.
    let placeholderText: String

    /// True is field is secured.
    var isSecureField: Bool? = false

    var body: some View {
        HStack {
            if isSecureField ?? false {
                SecureField(placeholderText, text: $text)
                    .autocapitalization(.none)
            } else {
                TextField(placeholderText, text: $text)
                    .autocapitalization(.none)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.secondary)
        )
    }
}

struct FormInputField_Previews: PreviewProvider {
    static var previews: some View {
        FormInputField(text: .constant(""), placeholderText: "Email")
    }
}
