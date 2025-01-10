//
//  SignInView.swift
//  Avra
//
//  Created by Daniel Istrati on 30.11.2024.
//

import SwiftUI

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
        
        Button("Sign In") {
            signIn(email: email, password: password)
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
    
    func signIn(email: String, password: String) {
           // let hashedPassword = hashPassword(password)
            // Logic to verify hashedPassword with the one in the database
        }
}


#Preview {
    SignInView()
}



