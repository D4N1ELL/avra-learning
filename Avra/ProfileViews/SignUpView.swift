//
//  SignUpView.swift
//  Avra
//
//  Created by Daniel Istrati on 30.11.2024.
//

import SwiftUI
import ClerkSDK

struct SignUpView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var code = ""
  @State private var isVerifying = false

  var body: some View {
    VStack {
        Text("Sign Up")
            .font(.largeTitle)
            .bold()
            .padding(.top)
            .padding(.leading)
        
      if isVerifying {
        TextField("Code", text: $code)
              .padding(.leading, 30)
              .frame(height: 40)
              .background(Color(.systemGray6))
              .cornerRadius(10)
          
        Button("Verify") {
          Task { await verify(code: code) }
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
        .padding()
          
      } else {
        TextField("Email", text: $email)
              .autocapitalization(.none)
              .keyboardType(.emailAddress)
              .padding(.leading, 30)
              .frame(height: 40)
              .background(Color(.systemGray6))
              .cornerRadius(10)
          
          
        SecureField("Password", text: $password)
              .padding(.leading, 30)
              .frame(height: 40)
              .background(Color(.systemGray6))
              .cornerRadius(10)
          
        Button("Continue") {
          Task { await signUp(email: email, password: password) }
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
        .padding()
      }
    }
    .padding()
  }
}

extension SignUpView {

  func signUp(email: String, password: String) async {
    do {
      let signUp = try await SignUp.create(
        strategy: .standard(emailAddress: email, password: password)
      )

      try await signUp.prepareVerification(strategy: .emailCode)

      isVerifying = true
    } catch {
      dump(error)
    }
  }

  func verify(code: String) async {
    do {
      guard let signUp = Clerk.shared.client?.signUp else {
        isVerifying = false
        return
      }

      try await signUp.attemptVerification(.emailCode(code: code))
    } catch {
      dump(error)
    }
  }

}

#Preview {
    SignUpView()
}
