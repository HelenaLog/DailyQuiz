import Foundation

enum GamePhase: Int {
    case loading
    case start
    case game
}

final class QuizViewModel: ObservableObject {
    
    @Published private(set) var trivia: [Results] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = AttributedString()
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published private(set) var date: Date = Date.now
    @Published private(set) var errorMessage: String = String()
    @Published private(set) var selectedAnswers: [Int: Answer] = [:]
    @Published private(set) var gameTime: Double = 10
    @Published private(set) var time: Double = 0
    @Published var gamePhase: GamePhase = .start
}

extension QuizViewModel {
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        selectedAnswers[index] = answer
        if answer.isCorrect {
            score += 1
        }
    }
    
    func getToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
         answerSelected = false
         progress = CGFloat(Double(index + 1) / Double(length) * 360)
         
         if index < length {
             let currentQuestion = trivia[index]
             question = currentQuestion.formattedQuestion
             answerChoices = currentQuestion.answers
             print("Question \(index) answers: \(answerChoices.map { "\($0.text): \($0.isCorrect)" })")
         }
        
     }
}
