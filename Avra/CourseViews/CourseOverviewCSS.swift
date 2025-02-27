//
//  CourseOverviewCSS.swift
//  Avra
//
//  Created by Daniel Istrati on 10.01.2025.
//

import SwiftUI
import WebKit

struct CourseOverviewCSS: View {
    @Binding var course: Course
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedInfo = "modules" // Toggle between "modules" and "info"
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 10) {
                ScrollView {
                    Text("CSS Basics")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    // Embedded YouTube Video
                    WebViewCSS(url: URL(string: "https://www.youtube.com/embed/OEV8gMkCHXQ?si=jZdsONHmyuyU4reF")!)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding()
                    
                    
                    VStack {
                        HStack {
                            Spacer()
                            Label("4.7", systemImage: "star.fill")
                                .foregroundColor(.gray)
                            Text("•")
                                .foregroundColor(.gray)
                            Label("Mentor Support", systemImage: "person.2.fill")
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Label("15 Lessons", systemImage: "book.fill")
                                .foregroundColor(.gray)
                            Text("•")
                                .foregroundColor(.gray)
                            Label("24 Hours", systemImage: "clock.fill")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    .font(.footnote)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    
                    // Picker for switching views
                    Picker("Information", selection: $selectedInfo) {
                        Text("Modules").tag("modules")
                        Text("General Info").tag("info")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if selectedInfo == "modules" {
                        VStack {
                            Text("Module 1")
                                .padding()
                                .font(.headline)
                            Text("Basic Concepts")
                                .font(.headline)
                            
                            VStack() {
                                Text("Program Structure")
                                Text("Data Types")
                                Text("Taking input")
                                Text("Output Formatting")
                                Text("Variables")
                                Text("Quiz")
                            }
                            .padding(.horizontal)
                            
                            NavigationLink(destination: LessonViewC()) {
                                Text("Learn")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                        
                        VStack {
                            Text("Module 2")
                                .padding()
                                .font(.headline)
                            Text("Conditions and loops")
                                .font(.headline)
                            
                            VStack() {
                                Text("Statements")
                                
                                Text("Program Structure")
                                Text("Output Formatting")
                                Text("Variables")
                                Text("Data Types")
                                Text("Quiz")
                            }
                            .padding(.horizontal)
                            
                            NavigationLink(destination: LessonViewHTML()) {
                                Text("Learn")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                        
                        VStack {
                            Text("Module 3")
                                .padding()
                                .font(.headline)
                            Text("Arrays and strings")
                                .font(.headline)
                            
                            VStack() {
                                Text("Arrays")
                                Text("Strings")
                                Text("Output Formatting")
                                Text("Variables")
                                Text("Data Types")
                                Text("Quiz")
                            }
                            .padding(.horizontal)
                            
                            NavigationLink(destination: LessonViewHTML()) {
                                Text("Learn")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                        
                    } else {
                        Text("Do you want to create powerful programs that run fast… faster than those written in other languages? C is a language that’s easy to write, allows for fast debugging, and is a building block for many other programming languages. With this course you’ll learn the foundations of this powerful and advanced programming language. No prior coding experience is necessary, we’ll teach you everything you need to know in a clear, simple way that’s perfect for beginners.")
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding()
                    }
                }
                
                
//                Button(course.isEnrolled ? "Unenroll" : "Enroll") {
//                    course.isEnrolled.toggle()
//                }
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .cornerRadius(10)
//                .background(course.isEnrolled ? Color.red : Color.blue)
//                .padding()
            
            }
        }
    }
    
    
}


// WebView to embed YouTube video
struct WebViewCSS: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}



