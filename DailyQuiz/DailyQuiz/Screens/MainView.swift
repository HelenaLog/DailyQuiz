import SwiftUI

struct MainView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var vm: QuizViewModel
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            switch vm.gamePhase {
            case .loading:
                GameLoadView()
                    .environmentObject(vm)
                    .transition(.opacity)
            case .start:
                StartView()
                    .environmentObject(vm)
                    .transition(.slide)
            case .game:
                if vm.reachedEnd {
                    ResultView()
                        .environmentObject(vm)
                        .transition(.opacity)
                } else {
                    QuestionView()
                        .environmentObject(vm)
                        .transition(.slide)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
