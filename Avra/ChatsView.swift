//
//  ChatsView.swift
//  Avra
//
//  Created by Daniel Istrati on 10.01.2025.
//

import SwiftUI
import Foundation

struct ChatSession: Identifiable {
    let id = UUID()
    let personName: String
    let lastMessage: String
    let timestamp: String
}



struct ChatsView: View {
    let chatSessions: [ChatSession] = [
        ChatSession(personName: "Alice", lastMessage: "Hey, are you free today?", timestamp: "09:45 AM"),
        ChatSession(personName: "Bob", lastMessage: "Got your notes, thanks!", timestamp: "Yesterday"),
        ChatSession(personName: "Charlie", lastMessage: "See you tomorrow!", timestamp: "Monday")
    ]

    var body: some View {
        NavigationView {
            List(chatSessions) { session in
                NavigationLink(destination: ChatView(chatSession: session)) {
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .overlay(Text(String(session.personName.prefix(1))))
                            .foregroundColor(.blue)
                            .padding(.trailing, 8)

                        VStack(alignment: .leading) {
                            Text(session.personName)
                                .font(.headline)
                            Text(session.lastMessage)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Text(session.timestamp)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitle("Chats")
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
