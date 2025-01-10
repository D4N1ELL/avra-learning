import SwiftUI
import Foundation

// Sample data models
struct LessonCSS: Codable {
    let title: String
    let content: String
    let quiz: QuizCSS
}

struct QuizCSS: Codable {
    let question: String
    let options: [String]
    let answer: String
}

func loadLessonsCSS(from filename: String) -> [LessonCSS] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        print("File not found: \(filename).json")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let lessonsCSS = try JSONDecoder().decode([LessonCSS].self, from: data)
        return lessonsCSS
    } catch {
        print("Error loading or decoding JSON: \(error)")
        return []
    }
}

let lessonsCSS = loadLessonsCSS(from: "lessonsCSS")
var currentLessonCSSIndex = 0

// Main Lesson View
struct LessonViewCSS: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var lessonsCSS: [LessonCSS] = loadLessonsCSS(from: "lessonsCSS")
    @State private var currentLessonCSSIndex = 0
    @State private var showQuiz = false
    @State private var showResult = false
    @State private var selectedOption: String? = nil
    
    var body: some View {
        VStack {
                    HStack {
                        // Progress Indicator
                        Text("Progress: \(currentLessonCSSIndex) / \(lessonsCSS.count)")
                            .font(.subheadline)
                            .padding(.leading)
                        Spacer()

                    }
                    .padding(.top)

                    if currentLessonCSSIndex < lessonsCSS.count {
                        let currentLessonCSS = lessonsCSS[currentLessonCSSIndex]
                        if !showQuiz {
                            // Display the lesson content
                            VStack(alignment: .leading, spacing: 20) {
                                Text(currentLessonCSS.title)
                                    .font(.title)
                                    .bold()
                                Text(currentLessonCSS.content)
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
                            QuizViewCSS(
                                quiz: currentLessonCSS.quiz,
                                onCompletion: { isCorrect in
                                    showResult = true
                                    if isCorrect {
                                        currentLessonCSSIndex += 1
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
                    
                    
                    Button("Back to Course View") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
        }
    }
}
// Quiz View
struct QuizViewCSS: View {
    let quiz: QuizCSS
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

//struct LessonViewCSS_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonViewCSS()
//    }
//}
