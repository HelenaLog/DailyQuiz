import SwiftUI

struct QuestionView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(alignment: .center, spacing: 10) {
                Button(action: {
                    print("Back button tapped")
                    vm.gamePhase = .start
                }) {
                    NavigationLink {
                        StartView()
                            .environmentObject(vm)
                    } label: {
                        Image(.leftIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 180, maxHeight: 40.6)
                    .frame(alignment: .center)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: 20) {
                TimeProgress()
                    .environmentObject(vm)
                Text("Вопрос \(vm.index + 1) из \(vm.length)")
                    .font(.custom(.interRegularBold, size: 16))
                    .foregroundStyle(Color.lightPurpleApp)
                
                Text(vm.question)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color.black)
                
                ForEach(vm.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(vm)
                }
                
                Button {
                    vm.getToNextQuestion()
                } label: {
                    PrimaryButton(text: "ДАЛЕЕ", backgroundColor: vm.answerSelected ? Color.lightPurpleApp : Color.grayApp)
                }
                .disabled(!vm.answerSelected)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
            .background(Color.white)
            .cornerRadius(46)
            
            Text("Вернуться к предыдущим вопросам нельзя")
                .font(.custom(.interRegular, size: 10))
                .foregroundStyle(Color.white)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightPurpleApp)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    QuestionView()
        .environmentObject(QuizViewModel())
}
