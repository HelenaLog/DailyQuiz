import SwiftUI

struct AnswerView: View {
    @EnvironmentObject var vm: QuizViewModel
    var question: AttributedString
    var answers: [Answer]
    var questionNumber: Int
    var totalQuestions: Int
    var questionIndex: Int
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Вопрос \(questionNumber) из \(totalQuestions)")
                    .font(.custom(.interRegularBold, size: 16))
                    .foregroundStyle(Color.grayApp)
                Spacer()
                Image(isCorrectAnswerSelected ? .selectedRight : .selectedWrong)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            Text(question)
                .multilineTextAlignment(.leading)
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(Color.black)
            
            ForEach(answers.indices, id: \.self) { index in
                HStack(spacing: 20) {
                    Image(answerIcon(for: answers[index], at: index))
                        .foregroundStyle(color(for: answers[index], at: index))
                    Text(answers[index].text)
                        .foregroundStyle(color(for: answers[index], at: index))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(backgroundColor(for: answers[index], at: index))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color(for: answers[index], at: index), lineWidth: 1)
                )
                .cornerRadius(16)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
        .background(Color.white)
        .cornerRadius(46)
    }
    
    private var isCorrectAnswerSelected: Bool {
        guard let selectedAnswer = vm.selectedAnswers[questionIndex] else {
             return false
         }
         let isCorrect = selectedAnswer.isCorrect
         return isCorrect
    }
}

// MARK: - Private methods

private extension AnswerView {

    func answerIcon(
        for answer: Answer,
        at index: Int
    ) -> String {
            guard let selectedAnswer = vm.selectedAnswers[questionIndex],
                  selectedAnswer.text == answer.text else {
                return "radio"
            }
        return answer.isCorrect ? "selectedRight" : "selectedWrong"
    }
    
    func color(
        for answer: Answer,
        at index: Int
    ) -> Color {
        guard let selectedAnswer = vm.selectedAnswers[questionIndex],
              selectedAnswer.text == answer.text else {
            return .black
        }
        return answer.isCorrect ? .greenApp : .redApp
    }
    
    func backgroundColor(
        for answer: Answer,
        at index: Int
    ) -> Color {
        guard let selectedAnswer = vm.selectedAnswers[questionIndex],
              selectedAnswer.text == answer.text else {
            return .lightGrayApp
        }
        return .clear
    }
}

#Preview {
    AnswerView(question: "Aboba", answers: [
        Answer(text: "Answer1", isCorrect: true),
        Answer(text: "Answer2", isCorrect: false),
        Answer(text: "Answer3", isCorrect: false),
        Answer(text: "Answer4", isCorrect: false),
    ],
               questionNumber: 1,
               totalQuestions: 5,
               questionIndex: 1
               
               
    )
    .environmentObject(QuizViewModel())
}
