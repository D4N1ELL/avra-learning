//
//  ProfileView.swift
//  Avra
//
//  Created by Daniel Istrati on 16.10.2024.
//

import SwiftUI
import ClerkSDK

struct ProfileView: View {
    @ObservedObject private var clerk = Clerk.shared
    
    var body: some View {
      VStack {
        if let user = clerk.user {
          Text("Hello, \(user.id)")
            Button("Sign Out") {
                Task { try? await clerk.signOut() }
            }
        } else {
            SignUpOrSignInView()
        }
      }
    }
}


#Preview {
    ProfileView()
}
