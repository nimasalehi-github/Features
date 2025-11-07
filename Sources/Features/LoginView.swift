//
//  LoginView.swift
//  
//
//  Created by Nima Salehi on 11/7/25.
//

import SwiftUI
import Core

public struct LoginView: View {
    @ObservedObject private var vm = LoginViewModel()
    @Binding var isLoggedIn: Bool

    public init(isLoggedIn: Binding<Bool>) {
        _isLoggedIn = isLoggedIn
    }

    public var body: some View {
        VStack(spacing: 20) {
            Text("🔐 Login")
                .font(.title)
                .bold()

            TextField("Username", text: $vm.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if vm.isLoading {
                ProgressView()
            }

            Button("Login") {
                Task {
                    let success = await vm.loginAsync()
                    if success {
                        isLoggedIn = true
                    } else {
                        vm.errorMessage = "❌ Invalid credentials"
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isLoading)

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding()
    }
}

