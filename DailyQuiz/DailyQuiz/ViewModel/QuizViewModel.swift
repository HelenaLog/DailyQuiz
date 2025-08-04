import Foundation
import Combine

enum GamePhase: Int {
    case loading
    case start
    case game
    case history
}

final class QuizViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published private(set) var trivia: [Results] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = AttributedString()
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published var gamePhase: GamePhase = .start
    @Published var date: Date = Date.now
    @Published var errorMessage: String = String()
    @Published var selectedAnswerIndices = [Int: Int]()
    @Published var selectedAnswers: [Int: Answer] = [:]
    @Published var allQuiz: [Quiz] = UserDefaultsStorage.shared.read(forKey: "allQuiz") ?? []
    @Published var gameTime: Double = 300
    @Published var time: Double = 0
    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    private let storage: UserDefaultsStorage
    private let apiService: APIServiceType
    
    // MARK: Init
    
    init(
        storage: UserDefaultsStorage = UserDefaultsStorage.shared,
        apiService: APIServiceType = TriviaNetworkClient.shared
    ) {
        self.storage = storage
        self.apiService = apiService
    }
}

// MARK: - Public methods

extension QuizViewModel {
    
     @MainActor func fetchQuiz() async {
        gamePhase = .loading
        do {
            let triviaResult = try await apiService.fetchQuestions()
            trivia = triviaResult.results
            length = trivia.count
            score = 0
            reachedEnd = false
            index = 0
            score = 0
            progress = 0.00
            selectedAnswerIndices = [:]
            selectedAnswers = [:]
            setQuestion()
            setupTimer()
            gamePhase = .game
        } catch {
            self.gamePhase = .start
            errorMessage = "Ошибка! Попробуйте еще раз"
        }
    }
    
     func getToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
            processUnansweredQuestions()
            saveNewQuiz()
            resetTimer()
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        selectedAnswers[index] = answer
        if answer.isCorrect {
            score += 1
        }
    }
    
    func saveNewQuiz() {
        let item = Quiz(
            number: allQuiz.count + 1,
            rating: score,
            date: date
        )
        allQuiz.append(item)
        saveData()
        getData()
    }
    
    func deleteQuiz(at id: String) {
        if let index = allQuiz.firstIndex(where: { $0.id == id }) {
            allQuiz.remove(at: index)
        }
        allQuiz = allQuiz.enumerated().map { (index, quiz) in
            Quiz(
                id: quiz.id,
                number: index + 1,
                rating: quiz.rating,
                date: quiz.date
            )
        }
        saveData()
    }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        let dayMonthString = dateFormatter.string(from: date)
        return dayMonthString
    }
    
    func hourFormatter(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dayMonthString = dateFormatter.string(from: time)
        return dayMonthString
    }
}

// MARK: - Private methods

private extension QuizViewModel {
    
    func setQuestion() {
         answerSelected = false
         progress = CGFloat(Double(index + 1) / Double(length) * 360)
         
         if index < length {
             let currentQuestion = trivia[index]
             question = currentQuestion.formattedQuestion
             answerChoices = currentQuestion.answers
         }
        
     }
    
    func saveData() {
        storage.save(structs: allQuiz, forKey: "allQuiz")
    }
    
    func getData() {
        allQuiz = storage.read(forKey: "allQuiz") ?? []
    }
    
    func deleteAllData() {
        storage.delete(forKey: "allQuiz")
    }
    
    func setupTimer() {
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                time += 0.1
                if time >= gameTime {
                    resetTimer()
                    processUnansweredQuestions()
                    reachedEnd = true
                    saveNewQuiz()
                }
            }
            .store(in: &cancellables)
    }
    
    func resetTimer() {
        time = 0
        cancellables.forEach { $0.cancel() }
    }
    
    func processUnansweredQuestions() {
        for i in 0..<length {
            if selectedAnswers[i] == nil {
                if let incorrectAnswer = trivia[i].answers.first(where: { !$0.isCorrect }) {
                    selectedAnswers[i] = incorrectAnswer
                }
            }
        }
    }
}
