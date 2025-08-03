import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var vm: QuizViewModel
    @State private var isSelected = false
    var answer: Answer
    var green = Color.green
    var red = Color.red
    
    var body: some View {
        HStack(spacing: 20) {
            if isSelected {
                Image(answer.isCorrect ? "selectedRight" : "selectedWrong")
                    .foregroundStyle(answer.isCorrect ? .greenApp : .redApp)
                Text(answer.text)
                    .foregroundStyle(answer.isCorrect ? .greenApp : .redApp)
            } else {
                Image(.radio)
                    .font(.caption)
                Text(answer.text)
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(vm.answerSelected ? (isSelected ? Color.purple : Color.gray) : Color.purple)
        .background(isSelected ? Color.clear : Color.lightGrayApp)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? (answer.isCorrect ? .greenApp : .redApp) : .lightGrayApp, lineWidth: 1))
        .cornerRadius(16)
        .onTapGesture {
            if !vm.answerSelected{
                isSelected = true
                vm.selectAnswer(answer: answer)
            }
        }
    }
}

#Preview {
    AnswerRow(answer: Answer(text: "Single", isCorrect: false))
        .environmentObject(QuizViewModel())
}

