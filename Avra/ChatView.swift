//
//  SwiftUIView.swift
//  Avra
//
//  Created by Daniel Istrati on 10.01.2025.
//

import SwiftUI
import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool  // True if the message is from the current user
}

struct ChatView: View {
    var chatSession: ChatSession
    @Environment(\.presentationMode) var presentationMode
    @State private var messages: [Message] = [
        Message(text: "Hello there! I am here to assist you in your journey of learning C. Feel free to ask any questions", isCurrentUser: false),
    ]
    @State private var newMessage = ""

    var body: some View {
        VStack {
            List {
                ForEach(messages) { message in
                    HStack {
                        if message.isCurrentUser {
                            Spacer()
                            Text(message.text)
                                .padding()
                                .background(Color.blue)
                                .clipShape(ChatBubble(isCurrentUser: true))
                                .foregroundColor(.white)
                        } else {
                            Text(message.text)
                                .padding()
                                .background(Color.gray)
                                .clipShape(ChatBubble(isCurrentUser: false))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())

            HStack {
                TextField("Message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: sendMessage) {
                    Text("Send")
                }
                .padding()
            }
        }
        .navigationBarTitle("Chat", displayMode: .inline)
    }

    func sendMessage() {
        let newMessage = Message(text: newMessage, isCurrentUser: true)
        messages.append(newMessage)
        self.newMessage = ""  // Clear the input field
    }
}

// A simple view modifier to create chat bubbles
struct ChatBubble: Shape {
    var isCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if isCurrentUser {
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.maxX - 15, y: rect.maxY))
        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.minX + 15, y: rect.maxY))
        }
        return path
    }
}


