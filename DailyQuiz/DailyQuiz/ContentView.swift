import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: QuizViewModel
    
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
    ContentView()
}
