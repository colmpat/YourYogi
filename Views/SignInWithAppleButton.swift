//
//  SignInWithAppleButton.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

struct SignInWithAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButton()
    }
}
