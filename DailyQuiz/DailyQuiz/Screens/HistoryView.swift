import SwiftUI

struct HistoryView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text(Constants.StringConstants.historyTitle)
                .font(.custom(.interRegularBlack, size: Constants.TextConstants.titleFontSize))
                .foregroundStyle(Color.white)
                .padding(.bottom, Constants.SpacingConstants.titleBottomPadding)
            
            if vm.allQuiz.isEmpty {
                infoView
                    .padding(.horizontal, Constants.SpacingConstants.outerHorizontalPadding)
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: Constants.LogoConstants.width,
                        maxHeight: Constants.LogoConstants.height
                    )
                    .padding(.bottom, Constants.LogoConstants.bottomPadding)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(vm.allQuiz, id: \.id) { quiz in
                            HistoryRow(
                                number: quiz.number,
                                score: quiz.rating,
                                date: vm.dateFormatter(date: quiz.date),
                                time: vm.hourFormatter(time: quiz.date)
                            )
                            .padding(.horizontal, Constants.SpacingConstants.rowHorizontalPadding)
                            .contextMenu {
                                Button(role: .destructive) {
                                    withAnimation(.none) {
                                        vm.deleteQuiz(at: quiz.id)
                                    }
                                } label: {
                                    Label(Constants.StringConstants.deleteLabel, systemImage: Constants.StringConstants.trashIcon)
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purpleApp)
        .navigationBarHidden(true)
    }
    
    private var infoView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.CardConstants.cardCornerRadius)
                .foregroundStyle(.white)
            VStack(spacing: Constants.SpacingConstants.innerStackSpacing) {
                Text(Constants.StringConstants.noQuizText)
                    .multilineTextAlignment(.center)
                    .font(.custom(.interRegular, size: Constants.TextConstants.noQuizFontSize))
                startButton
            }
            .padding(Constants.SpacingConstants.cardPadding)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var startButton: some View {
        Button {
            vm.gamePhase = .start
        } label: {
            NavigationLink {
                StartView()
                    .environmentObject(vm)
            } label: {
                PrimaryButton(text: Constants.StringConstants.startButtonText)
            }
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(QuizViewModel())
}

// MARK: - Constants

private extension HistoryView {
    enum Constants {
        enum TextConstants {
            static let titleFontSize: CGFloat = 32
            static let noQuizFontSize: CGFloat = 20
            static let menuButtonFontSize: CGFloat = 16
        }
        
        enum SpacingConstants {
            static let titleBottomPadding: CGFloat = 40
            static let outerHorizontalPadding: CGFloat = 16
            static let rowHorizontalPadding: CGFloat = 27
            static let innerStackSpacing: CGFloat = 40
            static let cardPadding: CGFloat = 32
            static let menuButtonHorizontalPadding: CGFloat = 16
            static let outerPadding: CGFloat = 16
            static let titleTopPadding: CGFloat = 16
        }
        
        enum StringConstants {
            static let historyTitle = "История"
            static let noQuizText = "Вы еще не проходили ни одной викторины"
            static let startButtonText = "НАЧАТЬ ВИКТОРИНУ"
            static let deleteLabel = "Удалить"
            static let trashIcon = "trash"
        }
        
        enum LogoConstants {
            static let width: CGFloat = 180
            static let height: CGFloat = 40.6
            static let bottomPadding: CGFloat = 40.4
        }
        
        enum CardConstants {
            static let cardCornerRadius: CGFloat = 46
        }
        
        enum ButtonConstants {
            static let menuButtonCornerRadius: CGFloat = 16
        }
    }
}
