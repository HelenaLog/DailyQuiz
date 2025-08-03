import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var vm: QuizViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Результаты")
                .font(.custom(.interRegularBlack, size: 32))
                .foregroundStyle(Color.white)
            ScrollView {
                VStack {
                    HStack {
                        ForEach(0..<5, id: \.self) { score in
                            Image(score < vm.score ? "starActive" : "starInactive")
                        }
                    }
                    Text("\(vm.score) из \(vm.length)")
                        .font(.custom(.interRegularBold, size: 16))
                        .foregroundStyle(Color.yellowApp)
                        .padding(.bottom, 24)
                    
                    if let result = ResultType(rawValue: vm.score) {
                        Text(result.feedbackText)
                            .font(.custom(.interRegularBold, size: 24))
                            .padding(.bottom, 12)
                        Text(result.descriptionText)
                            .font(.custom(.interRegular, size: 16))
                            .multilineTextAlignment(.center)

                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
                .background(Color.white)
                .cornerRadius(46)
                
                Text("Твои ответы")
                    .font(.custom(.interRegularBlack, size: 32))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 40)
                VStack(spacing: 24) {
                    ForEach(Array(vm.trivia.enumerated()), id: \.element.id) { (index, result) in
                        AnswerView(
                            question: result.formattedQuestion,
                            answers: result.answers,
                            questionNumber: index + 1,
                            totalQuestions: vm.length,
                            questionIndex: index
                        )
                    }
                    .padding(.horizontal, 16)
                }
                
                Button {
                    vm.gamePhase = .start
                } label: {
                    NavigationLink{
                        StartView()
                            .environmentObject(vm)
                    } label: {
                        PrimaryButton(
                            text: "НАЧАТЬ ЗАНОВО",
                            textColor: .darkPurpleApp,
                            backgroundColor: .white
                        )
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleApp)
        .navigationBarHidden(true)
        .onAppear {
            vm.saveNewQuiz()
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(QuizViewModel())
}
