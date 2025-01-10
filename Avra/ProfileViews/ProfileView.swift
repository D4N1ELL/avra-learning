//
//  ProfileView.swift
//  Avra
//
//  Created by Daniel Istrati on 16.10.2024.
//

import SwiftUI

struct ProfileView: View {
    var name: String = "Daniel"  // Example user name, pass this as a variable if needed

    var body: some View {
        VStack {
            Spacer()

            // Image at the top center
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)  // Set the size as per your UI design
                .padding(.top, 50)

            // Greeting text
            Text("Hello, \(name)!")
                .font(.largeTitle)
                .padding(.top, 20)

            Spacer()

            // Log out button
            Button(action: {
                // Action for logging out
                print("User logged out")
            }) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
            }

            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

