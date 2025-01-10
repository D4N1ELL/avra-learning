//
//  SignUpView.swift
//  Avra
//
//  Created by Daniel Istrati on 30.11.2024.
//

import SwiftUI
import CryptoKit

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedUp = false
    @State private var signUpError: String?  // To display any error messages

    var body: some View {
        VStack {
            Text("Sign Up")
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
            
            Button("Sign Up") {
                signUp(email: email, password: password)
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
        

    func signUp(email: String, password: String) {
            let hashedPassword = hashPassword(password)
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try DatabaseManager.shared.addUser(email: email, password: hashedPassword)
                    DispatchQueue.main.async {
                        self.isSignedUp = true  // Indicate success on the UI
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.signUpError = "Failed to sign up: \(error.localizedDescription)"
                    }
                }
            }
    }
    
    func hashPassword(_ password: String) -> String {
        let hashed = SHA256.hash(data: Data(password.utf8))
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

