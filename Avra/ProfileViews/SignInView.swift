//
//  SignInView.swift
//  Avra
//
//  Created by Daniel Istrati on 30.11.2024.
//

import SwiftUI
import ClerkSDK

struct SignInView: View {
  @State private var email = ""
  @State private var password = ""
    
    


    
  var body: some View {
    VStack {
        Text("Sign In")
            .font(.largeTitle)
            .bold()
            .padding(.top)
            .padding(.leading)
        
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
        
      Button("Enroll") {
        Task { await submit(email: email, password: password) }
      }
      .font(.headline)
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.blue)
      .cornerRadius(10)
      .padding()
    }
    .padding()
  }
}

extension SignInView {

  func submit(email: String, password: String) async {
    do {
      try await SignIn.create(
        strategy: .identifier(email, password: password)
      )
    } catch {
      dump(error)
    }
  }

}

#Preview {
    SignInView()
}
