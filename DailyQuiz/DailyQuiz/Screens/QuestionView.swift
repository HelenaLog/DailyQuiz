import SwiftUI

struct QuestionView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack {
            HStack(
                alignment: .center,
                spacing: Constants.SpacingConstants.headerHStackSpacing
            ) {
                Button(action: {
                    vm.gamePhase = .start
                }) {
                    NavigationLink {
                        StartView()
                            .environmentObject(vm)
                    } label: {
                        Image(.leftIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: Constants.IconConstants.leftIconSize,
                                height: Constants.IconConstants.leftIconSize
                            )
                    }
                }
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: Constants.LogoConstants.width, maxHeight: Constants.LogoConstants.height)
                    .frame(alignment: .center)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, Constants.SpacingConstants.headerToCardSpacing)
            VStack(spacing: Constants.SpacingConstants.innerStackSpacing) {
                TimeProgress()
                    .environmentObject(vm)
                    .frame(height: Constants.TimeProgressConstants.height)
                Text("\(Constants.StringConstants.questionPrefix) \(vm.index + 1) \(Constants.StringConstants.questionSuffix) \(vm.length)")
                    .font(.custom(.interRegularBold, size: Constants.TextConstants.questionNumberFontSize))
                    .foregroundStyle(Color.lightPurpleApp)
                Text(vm.question)
                    .multilineTextAlignment(.center)
                    .font(.custom(.interRegularSemibold, size: Constants.TextConstants.questionFontSize))
                    .frame(maxWidth: .infinity, alignment: .center)
                ForEach(vm.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(vm)
                }
                Button {
                    vm.getToNextQuestion()
                } label: {
                    PrimaryButton(text: Constants.StringConstants.nextButtonText, backgroundColor: vm.answerSelected ? Color.purpleApp : Color.grayApp)
                }
                .disabled(!vm.answerSelected)
            }
            .padding(.horizontal, Constants.CardConstants.horizontalPadding)
            .padding(.vertical, Constants.CardConstants.verticalPadding)
            .background(Color.white)
            .cornerRadius(Constants.CardConstants.cardCornerRadius)
            .padding(.bottom, Constants.SpacingConstants.cardToNoReturnSpacing)
            Text(Constants.StringConstants.noReturnText)
                .font(.custom(.interRegular, size: Constants.TextConstants.noReturnFontSize))
                .foregroundStyle(Color.white)
        }
        .padding(Constants.SpacingConstants.outerPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleApp)
        .navigationBarHidden(true)
    }
}

#Preview {
    QuestionView()
        .environmentObject(QuizViewModel())
}

// MARK: - Constants

private extension QuestionView {
    enum Constants {
        enum TextConstants {
            static let questionNumberFontSize: CGFloat = 16
            static let questionFontSize: CGFloat = 18
            static let noReturnFontSize: CGFloat = 10
        }
        
        enum SpacingConstants {
            static let headerHStackSpacing: CGFloat = 10
            static let innerStackSpacing: CGFloat = 20
            static let outerPadding: CGFloat = 26
            static let headerToCardSpacing: CGFloat = 40
            static let cardToNoReturnSpacing: CGFloat = 16
        }
        
        enum StringConstants {
            static let questionPrefix = "Вопрос"
            static let questionSuffix = "из"
            static let nextButtonText = "ДАЛЕЕ"
            static let noReturnText = "Вернуться к предыдущим вопросам нельзя"
        }
        
        enum LogoConstants {
            static let width: CGFloat = 180
            static let height: CGFloat = 40.6
        }
        
        enum IconConstants {
            static let leftIconSize: CGFloat = 24
        }
        
        enum CardConstants {
            static let horizontalPadding: CGFloat = 24
            static let verticalPadding: CGFloat = 32
            static let cardCornerRadius: CGFloat = 46
        }
        
        enum TimeProgressConstants {
            static let height: CGFloat = 23.53
        }
    }
}
