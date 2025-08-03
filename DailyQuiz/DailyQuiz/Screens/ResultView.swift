import SwiftUI

struct ResultView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack() {
            Text(Constants.StringConstants.resultsTitle)
                .font(.custom(.interRegularBlack, size: Constants.TextConstants.titleFontSize))
                .foregroundStyle(Color.white)
                .padding(.bottom, Constants.SpacingConstants.titleBottomPadding)
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(0..<Constants.ScoreConstants.maxStars, id: \.self) { score in
                            Image(score < vm.score ? Constants.StringConstants.starActive : Constants.StringConstants.starInactive)
                        }
                    }
                    Text("\(vm.score) из \(vm.length)")
                        .font(.custom(.interRegularBold, size: Constants.TextConstants.scoreFontSize))
                        .foregroundStyle(Color.yellowApp)
                        .padding(.bottom, Constants.SpacingConstants.scoreBottomPadding)
                    
                    if let result = ResultType(rawValue: vm.score) {
                        Text(result.feedbackText)
                            .font(.custom(.interRegularBold, size: Constants.TextConstants.feedbackFontSize))
                            .padding(.bottom, Constants.SpacingConstants.feedbackBottomPadding)
                        Text(result.descriptionText)
                            .font(.custom(.interRegular, size: Constants.TextConstants.descriptionFontSize))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, Constants.CardConstants.horizontalPadding)
                .padding(.vertical, Constants.CardConstants.verticalPadding)
                .background(Color.white)
                .cornerRadius(Constants.CardConstants.cardCornerRadius)
                
                Text(Constants.StringConstants.yourAnswersTitle)
                    .font(.custom(.interRegularBlack, size: Constants.TextConstants.titleFontSize))
                    .foregroundStyle(Color.white)
                    .padding(.vertical, Constants.SpacingConstants.answersTitleVerticalPadding)
                VStack {
                    ForEach(Array(vm.trivia.enumerated()), id: \.element.id) { (index, result) in
                        AnswerView(
                            question: result.formattedQuestion,
                            answers: result.answers,
                            questionNumber: index + 1,
                            totalQuestions: vm.length,
                            questionIndex: index
                        )
                    }
                }
                
                Button {
                    vm.gamePhase = .start
                } label: {
                    NavigationLink{
                        StartView()
                            .environmentObject(vm)
                    } label: {
                        PrimaryButton(
                            text: Constants.StringConstants.restartButtonText,
                            textColor: .darkPurpleApp,
                            backgroundColor: .white
                        )
                    }
                }
                .padding(.horizontal, Constants.SpacingConstants.buttonHorizontalPadding)
            }
        }
        .padding(Constants.SpacingConstants.outerPadding)
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

// MARK: - Constants

private extension ResultView {
    enum Constants {
        enum TextConstants {
            static let titleFontSize: CGFloat = 32
            static let scoreFontSize: CGFloat = 16
            static let feedbackFontSize: CGFloat = 24
            static let descriptionFontSize: CGFloat = 16
        }
        
        enum SpacingConstants {
            static let titleBottomPadding: CGFloat = 32
            static let scoreBottomPadding: CGFloat = 24
            static let feedbackBottomPadding: CGFloat = 12
            static let answersTitleVerticalPadding: CGFloat = 32
            static let buttonHorizontalPadding: CGFloat = 40
            static let outerPadding: CGFloat = 16
        }
        
        enum StringConstants {
            static let resultsTitle = "Результаты"
            static let yourAnswersTitle = "Твои ответы"
            static let restartButtonText = "НАЧАТЬ ЗАНОВО"
            static let starActive = "starActive"
            static let starInactive = "starInactive"
        }
        
        enum CardConstants {
            static let horizontalPadding: CGFloat = 24
            static let verticalPadding: CGFloat = 32
            static let cardCornerRadius: CGFloat = 46
        }
        
        enum ScoreConstants {
            static let maxStars: Int = 5
        }
    }
}
