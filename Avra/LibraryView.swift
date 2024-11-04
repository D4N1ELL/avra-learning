//
//  LibraryView.swift
//  Avra
//
//  Created by Daniel Istrati on 17.10.2024.
//

import SwiftUI

import SwiftUI

struct LibraryView: View {
    @State private var searchText: String = ""
    @Binding var isTabBarVisible: Bool
    
    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courseData
        } else {
            return courseData.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    headerView
                    SearchBar(text: $searchText)
                    coursesListView
                }
                .padding(.bottom)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    // Subview for the header
    private var headerView: some View {
        Text("Courses")
            .font(.largeTitle)
            .bold()
            .padding(.top)
            .padding(.leading)
    }

    // Subview for the list of courses
    private var coursesListView: some View {
        ScrollView {
            VStack(spacing: 15) {
                if filteredCourses.isEmpty {
                    Text("No course found with this name")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                } else {
                    ForEach(filteredCourses) { course in
                        NavigationLink(destination: CourseOverview(isTabBarVisible: $isTabBarVisible)) {
                                CourseRow(course: course)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// Search Bar Component
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
            HStack {
                TextField("Search...", text: $text)
                    .padding(.leading, 30)
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    )
            }
            .padding(.horizontal)
        }
}

    struct CourseRow: View {
        let course: Course

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Image(course.imageName)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)

                    VStack(alignment: .leading, spacing: 5) {
                        Text(course.name)
                            .font(.headline)
                        
                        Text(course.briefDescription)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                
                // Greyed information area at the bottom, fits the full width
                VStack {
                    HStack {
                        Spacer()
                        
                        Label("\(course.rating, specifier: "%.1f")", systemImage: "star.fill")
                            .foregroundColor(.gray)
                        
                        // Dot separator
                        Text("•")
                            .foregroundColor(.gray)
                        
                        Label(course.mentorSupport ? "Mentor Support" : "No Mentor Support", systemImage: "person.2.fill")
                            .foregroundColor(.blue)

                        Spacer() // Ensures items are evenly spaced
                    }
                    
                    HStack {
                        Spacer()
                        
                        Label("\(course.numberOfLessons) Lessons", systemImage: "book.fill")
                            .foregroundColor(.gray)
                        
                        // Dot separator
                        Text("•")
                            .foregroundColor(.gray)
                        
                        Label("\(course.hoursToComplete) Hours", systemImage: "clock.fill")
                            .foregroundColor(.gray)

                        Spacer() // Ensures items are evenly spaced
                    }
                }
                .font(.footnote)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: .infinity) // Make the greyed area fit the full width
            }
            .padding() // Add margin around each course
            .background(Color(.systemGray5)) // Background color for the course row
            .cornerRadius(12) // Rounded corners for the course row
        }
}

// Course model
struct Course: Identifiable {
        let id = UUID()
        let name: String
        let briefDescription: String
        let imageName: String
        let rating: Double
        let mentorSupport: Bool
        let numberOfLessons: Int
        let hoursToComplete: Int
}

// Mock data
let courseData = [
    Course(name: "C basics", briefDescription: "Master the foundational concepts of C language and write your first C program.", imageName: "C-lang.png", rating: 4.5, mentorSupport: true, numberOfLessons: 10, hoursToComplete: 5),
    
    Course(name: "HTML basics", briefDescription: "Learn the basic structure of a webpage.", imageName: "history_image", rating: 4.7, mentorSupport: false, numberOfLessons: 15, hoursToComplete: 8),
    
    Course(name: "CSS basics", briefDescription: "Discover how to create CSS styles, how to set different text font sizes, font styles and colors.", imageName: "history_image", rating: 4.7, mentorSupport: false, numberOfLessons: 15, hoursToComplete: 8)
]

#Preview {
    LibraryView(isTabBarVisible: .constant(true))
}
