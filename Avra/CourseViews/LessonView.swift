import SwiftUI
import Foundation

// Sample data models
struct Lesson: Codable {
    let title: String
    let content: String
    let quiz: Quiz
}

struct Quiz: Codable {
    let question: String
    let options: [String]
    let answer: String
}

func loadLessons(from filename: String) -> [Lesson] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        print("File not found: \(filename).json")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let lessons = try JSONDecoder().decode([Lesson].self, from: data)
        return lessons
    } catch {
        print("Error loading or decoding JSON: \(error)")
        return []
    }
}

let lessons = loadLessons(from: "lessons")
var currentLessonIndex = 0

// Main Lesson View
struct LessonView: View {
    @Binding var isTabBarVisible: Bool
    @State private var lessons: [Lesson] = loadLessons(from: "lessons")
    @State private var currentLessonIndex = 0
    @State private var showQuiz = false
    @State private var showResult = false
    @State private var selectedOption: String? = nil
    
    var body: some View {
        VStack {
                    HStack {
                        // Progress Indicator
                        Text("Progress: \(currentLessonIndex) / \(lessons.count)")
                            .font(.subheadline)
                            .padding(.leading)
                        Spacer()

                        NavigationLink(destination: CourseOverview(isTabBarVisible: $isTabBarVisible)) {
                            Text("Exit")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    .padding(.top)

                    if currentLessonIndex < lessons.count {
                        let currentLesson = lessons[currentLessonIndex]
                        if !showQuiz {
                            // Display the lesson content
                            VStack(alignment: .leading, spacing: 20) {
                                Text(currentLesson.title)
                                    .font(.title)
                                    .bold()
                                Text(currentLesson.content)
                                    .font(.body)

                                Button(action: {
                                    showQuiz = true
                                }) {
                                    Text("Next")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                .padding(.top)
                            }
                            .padding()
                        } else {
                        // Display the quiz
                            QuizView(
                                quiz: currentLesson.quiz,
                                onCompletion: { isCorrect in
                                    showResult = true
                                    if isCorrect {
                                        currentLessonIndex += 1
                                        showQuiz = false
                                        showResult = false
                                        selectedOption = nil
                                    }
                                },
                                selectedOption: $selectedOption,
                                showResult: $showResult
                            )
                        }
            } else {
                // Display course completion message
                VStack {
                    Text("Congratulations! You have completed the course.")
                        .font(.title)
                        .padding()
                    
                    NavigationLink(destination: CourseOverview(isTabBarVisible: $isTabBarVisible)) {
                        Text("Back to Course View")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}
// Quiz View
struct QuizView: View {
    let quiz: Quiz
    var onCompletion: (Bool) -> Void
    @Binding var selectedOption: String?
    @Binding var showResult: Bool

    var body: some View {
        VStack {
            Text(quiz.question)
                .font(.headline)

            ForEach(quiz.options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    showResult = true
                }) {
                    Text(option)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .padding(.vertical, 5)
                }
            }

            if showResult {
                Text(selectedOption == quiz.answer ? "Correct!" : "Try again!")
                    .font(.title)
                    .foregroundColor(selectedOption == quiz.answer ? .green : .red)

                // Display the "Next" button only if the answer is correct
                if selectedOption == quiz.answer {
                    Button(action: {
                        onCompletion(true)
                    }) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.top)
                    }
                }
            }
        }
        .padding()
    }
}

// Preview
struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(isTabBarVisible: .constant(false))
    }
}
