import Foundation

struct Trivia: Decodable {
    let results: [Results]
}

struct Results: Decodable, Identifiable {
    var id: UUID { UUID() }
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: question)
        } catch {
            print("Error setting formatted Question: \(error)")
            return AttributedString()
        }
    }
    
    var answers: [Answer] {
        do {
            let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
            let incorrect = try incorrectAnswers.map { answer in
                Answer(text: try AttributedString(markdown: answer), isCorrect: false)
            }
            let allAnswers = correct + incorrect
            return allAnswers.shuffled()
        } catch {
            print("Error setting answer: \(error)")
            return []
        }
    }
}
