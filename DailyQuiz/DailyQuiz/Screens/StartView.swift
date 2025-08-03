import SwiftUI

struct StartView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.CardConstants.stackSpacing) {
                VStack(spacing: Constants.CardConstants.innerStackSpacing) {
                    historyButton
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            maxWidth: Constants.LogoConstants.width,
                            maxHeight: Constants.LogoConstants.height
                        )
                        .padding(.bottom, Constants.LogoConstants.bottomPadding)

                    
                    VStack(spacing: Constants.CardConstants.stackSpacing) {
                        Text(Constants.StringConstants.welcomeText)
                            .multilineTextAlignment(.center)
                            .font(.custom(.interRegularBold, size: Constants.TextConstants.welcomeFontSize))
                            .foregroundStyle(Color.black)
                        Button {
                        } label: {
                            PrimaryButton(text: Constants.StringConstants.startButtonText)
                                .padding(.horizontal, 40)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 32)
                    .background(Color.white)
                    .cornerRadius(Constants.CardConstants.cardCornerRadius)
                    
                    Text("Ошибка! Попробуйте еще раз")
                        .font(.custom(.interRegularBold, size: Constants.TextConstants.errorFontSize))
                        .foregroundStyle(Color.white)
                    
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(.purpleApp)
            .onAppear {
                
            }
        }
    }
    
    private var historyButton: some View {
        Button {
            print("History")
        } label: {
            NavigationLink {
            } label: {
                HStack {
                    Text(Constants.StringConstants.historyButtonText)
                        .font(.custom(.interRegularSemibold, size: 12))
                    Image(.historyIcon)
                }
                .foregroundStyle(.purpleApp)
                .padding(12)
                .background(.white)
                .cornerRadius(24)
                .padding(.bottom, 114)
            }
        }
    }
}

#Preview {
    StartView()
        
}

// MARK: - Constants

private extension StartView {
    enum Constants {
        enum TextConstants {
            static let welcomeFontSize: CGFloat = 28
            static let errorFontSize: CGFloat = 20
            static let historyFontSize: CGFloat = 12
            static let buttonFontSize: CGFloat = 16
        }
        
        enum LogoConstants {
            static let width: CGFloat = 300
            static let height: CGFloat = 67.67
            static let bottomPadding: CGFloat = 40
        }
        
        enum ButtonConstants {
            static let buttonWidth: CGFloat = 280
            static let buttonHeight: CGFloat = 50
            static let buttonCornerRadius: CGFloat = 16
            static let historyCornerRadius: CGFloat = 24
            static let historyBottomPadding: CGFloat = 114
        }
        
        enum StringConstants {
            static let welcomeText = "Добро пожаловать в DailyQuiz!"
            static let startButtonText = "НАЧАТЬ ВИКТОРИНУ"
            static let historyButtonText = "История"
        }
        
        enum CardConstants {
            static let cardCornerRadius: CGFloat = 46
            static let cardPadding = EdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24)
            static let stackSpacing: CGFloat = 40
            static let innerStackSpacing: CGFloat = 20
        }
    }
}
